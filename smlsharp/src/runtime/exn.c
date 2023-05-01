/**
 * exn.c
 * @copyright (C) 2021 SML# Development Team.
 * @author UENO Katsuhiro
 */

#include "smlsharp.h"
#include <stdlib.h>
#include <string.h>
#include <unwind.h>
#ifdef HAVE_LIBUNWIND_H
#include <libunwind.h>
#endif
#include "object.h"

#define LANG_SMLSHARP     (('S'<<24)|('M'<<16)|('L'<<8)|'#')
#define VENDOR_SMLSHARP   ((uint64_t)LANG_SMLSHARP << 32)
#define EXNCLASS_SMLSHARP (VENDOR_SMLSHARP | LANG_SMLSHARP)

#define DW_EH_PE_omit     0xff
#define DW_EH_PE_uleb128  0x01
#define DW_EH_PE_udata4   0x03

/*
 * low-level exception object handled by Itanium C++ ABI.
 */
struct exception {
	void *exn_obj;           /* ML's exn object */
	void *handler_addr;      /* handler address found in SEARCH phase */
	struct _Unwind_Exception header;
	unsigned int num_cleanup;
};
#define UE_TO_EXCEPTION(ue) \
	((struct exception *)((char*)(ue) - offsetof(struct exception, header)))

/*
 * The internal structure of SML# exception objects.
 * See also EmitTypedLambda.sml.
 */
struct exn {
	struct exntag {
		const char *name;
		uint32_t msg_index;
	} **tag;
	const char *loc;
	void *arg;
};
#define FLAG_MSG_IN_ARG   0x1U
#define MASK_MSG_INDEX    (~(0x1U))

static const char *
exn_msg(const struct exn *e)
{
	uint32_t index = (*(e->tag))->msg_index;
	void *base;

	if (index == 0)
		return NULL;
	base = (index & FLAG_MSG_IN_ARG) ? (void*)e->arg : (void*)e;
	return *(void**)((char*)base + (index & MASK_MSG_INDEX));
}

static void ATTR_NORETURN
uncaught_exception(void *exnobj)
{
	const char dq = '"', sp = ' ';
	const struct exn *e = exnobj;
	const char *msg = exn_msg(e);
	int q = msg == NULL ? 0 : 1;

	sml_fatal(0, "uncaught exception: %s%.*s%.*s%s%.*s at %s",
		  (*(e->tag))->name, q, &sp, q, &dq, msg ? msg : "", q, &dq,
		  e->loc);
}

/* this never be called unless SML# compiler has a bug */
void
sml_matchcomp_bug()
{
	sml_fatal(0, "match compiler bug");
}

/* called if an SML# exception is caught by a handler in another language. */
static void
cleanup(_Unwind_Reason_Code reason ATTR_UNUSED,
	struct _Unwind_Exception *exc)
{
	free(exc);
}

void
sml_backtrace()
{
#ifdef HAVE_UNW_GETCONTEXT
	unw_context_t c;
	unw_cursor_t cursor;
	unw_proc_info_t i;
	char buf[128];
	unw_word_t offset;
	int r, count = 1;

	if (unw_getcontext(&c) != 0)
		return;
	if (unw_init_local(&cursor, &c) != 0)
		return;
	sml_error(0, "backtrace:");
	do {
		if (unw_get_proc_info(&cursor, &i) != 0)
			return;
		if (unw_get_proc_name(&cursor, buf, sizeof(buf), &offset) != 0)
			return;
		sml_error(0, "  frame #%d: %p %s + %llu",
			  count++, (void*)(i.start_ip + offset), buf,
			  (unsigned long long int)offset);
		r = unw_step(&cursor);
	} while (r > 0);
#endif /* HAVE_UNW_GETCONTEXT */
}

SML_PRIMITIVE void
sml_raise(void *arg)
{
	struct exception *e = arg;
	_Unwind_Reason_Code ret;

	assert(OBJ_SIZE(arg) >= sizeof(struct exception));
	assert(e->exn_obj != NULL);

	/* The exn object must be kept alive until control reaches an SML#
	 * exception handler, but must not be in a stack frame.  To protect
	 * it from GC, we perform unwinding of ML stack frames in SML#
	 * context.  Before switching to C stack frames, the exn object must
	 * be saved by sml_save_exn.
	 */
	e->header.exception_class = EXNCLASS_SMLSHARP;
	e->header.exception_cleanup = cleanup;
	e->handler_addr = NULL;
	e->num_cleanup = 0;

	/* Note: During stack unwinding, user C code may execute because
	 * of user cleanup handler such as C++ destructor.
	 * Note: We do not allow the garbage collector to move "e" object
	 * during stack unwinding.  C code possesses "e" until the control
	 * reaches SML#'s landingpad.
	 */
	ret = _Unwind_RaiseException(&e->header);

	/* control reaches here if unwinding failed */
	if (ret == _URC_END_OF_STACK) {
		sml_backtrace();
		uncaught_exception(e->exn_obj);
	}

	sml_fatal(0, "unwinding failed");
}

static uintptr_t
read_uleb128(const unsigned char **src_p)
{
	const unsigned char *src = *src_p;
	unsigned char c;
	uintptr_t result = 0;
	unsigned int shift = 0;

	do {
		c = *src++;
		result |= (uintptr_t)(c & 0x7f) << shift;
		shift += 7;
	} while (c & 0x80);

	*src_p = src;
	return result;
}

static uintptr_t
read_udata4(const unsigned char **src_p)
{
	uint32_t ret;
	memcpy(&ret, *src_p, 4);  /* prevent unaligned load */
	*src_p += 4;
	return ret;
}

#define CATCH 0x1
#define CLEANUP 0x2

struct landing_pad {
	unsigned int type;
	void *addr;    /* set only if type != 0. NULL means terminate */
};

static struct landing_pad
search_lpad(struct _Unwind_Context *context)
{
	const unsigned char *src, *actiontab;
	uintptr_t lpstart, tablen, ip, start, lpad, len;
	unsigned char encoding, action;
	struct landing_pad ret;

	/* The language-specific data is organized by LLVM in the following
	 * structure, which is compatible with GCC's except_tab
	 * (see EHStreamer::emitExceptionTable):
	 * struct packed {
	 *   uint8_t   lpstart_enc;  // always DW_EH_PE_omit (0xff)
	 * # uint8_t   ttype_enc;    // we ignore it
	 * # uleb128   ttype_off;    // we ignore it
	 * ! uint8_t   callsite_enc; // always DW_EH_PE_udata4 (0x03)
	 *   uleb128   callsite_len; // length of CallSiteTable in bytes
	 *   struct {
	 * !   udata4  cs_start;     // start address (relative to RegionStart)
	 * !   udata4  cs_len;       // code range length
	 * !   udata4  cs_lpad;      // landing pad address (ditto)
	 *     uleb128 action;       // ([index of action] + 1) or 0
	 *   } CallSiteTable[];
	 *   struct {
	 *     sleb128 type;         // 0 = cleanup, + = catch, - = filter
	 *     sleb128 next;         // next action (0 = end of actions)
	 }   } ActionTable[];
	 * };
	 *
	 * Note on ! lines:
	 * Up to LLVM 6, callsite table is encoded in udata4.
	 * From LLVM 7, LLVM uses uleb128 instead of udata4 for callsite table.
	 *
	 * Note on # lines:
	 * From LLVM 3.9, LLVM may set DW_EH_PE_omit to "ttype_enc" and
	 * therefore "ttype_off" may be omitted.
	 *
	 * For actions:  SML# uses three-kinds of actions: cleanup, catch-all,
	 * or both.  If "action" of CallSiteTable is 0, it is a cleanup handler.
	 * Otherwise, it is at least a catch-all handler.
	 * If there are more than one actions, namely "next" of ActionTable is
	 * non-zero, it is also a cleanup handler.
	 */
	src = (const unsigned char *)_Unwind_GetLanguageSpecificData(context);

	/* there is no LSDA */
	if (!src) {
		ret.type = 0; /* no landing pad */
		return ret;
	}

	if (*src++ != DW_EH_PE_omit)
		sml_fatal(0, "@LPStart must be omitted");
	lpstart = _Unwind_GetRegionStart(context);

	/* ignore @TType */
	if (*(src++) != DW_EH_PE_omit)
		read_uleb128(&src);

	/* LLVM seems to use only udata4 to generate call-site table */
	encoding = *(src++);
	if (encoding != DW_EH_PE_udata4 && encoding != DW_EH_PE_uleb128)
		sml_fatal(0, "call-site table encoding must be either "
			  "udata4 or uleb128");
	tablen = read_uleb128(&src);
	actiontab = src + tablen;

	/*
	 * LLVM generates an empty call site table for a function where its
	 * "personality" attribute is set to an uncommon name and no
	 * landingpad is included in its body.  Such a function may be
	 * generated by code optimization; therefore, we cannot inherently
	 * avoid generating such a function.
	 *
	 * An empty call site table means that an exception is never raised
	 * everywhere in its corresponding function.  This is obviously
	 * unexpected.  Unlike C++, SML# program does not have any code point
	 * that raising an exception is prohibited.  This also unexpectedly
	 * prevents sml_raise from working.
	 *
	 * According to my quick reading on LLVM source code, if there is
	 * at least one landingpad in a function, LLVM generates a non-empty
	 * call site table covering the entire function body.
	 *
	 * The following check is needed for this reason.
	 * If the call site table is empty, then it contains no landingpad.
	 */
	if (tablen == 0) {
		ret.type = 0; /* no landing pad */
		return ret;
	}

	ip = _Unwind_GetIP(context);

	/* Each entry in the call site table indicates a range of the address
	 * of call instructions.  In contrast, _Unwind_GetIP usually returns
	 * the address of the next instruction of a call instruction.
	 * Decrement ip here so that ip points to the middle of a call
	 * instruction.
	 */
	ip--;

	while (src < actiontab) {
		if (encoding == DW_EH_PE_uleb128) {
			start = read_uleb128(&src);
			len = read_uleb128(&src);
			lpad = read_uleb128(&src);
		} else {
			start = read_udata4(&src);
			len = read_udata4(&src);
			lpad = read_udata4(&src);
		}
		action = *(src++);
		start += lpstart;

		if (action >= 0x80)
			sml_fatal(0, "action too large");

		/* call-site table is sorted by cs_start.
		 * Exit the iteration if we have passed the given IP */
		if (ip < start)
			break;

		if (ip < start + len) {
			/* In SML#, there are only three kinds of landing pads:
			 * cleanup, catch i8* null, and cleanup catch i8* null.
			 */
			if (lpad == 0)
				ret.type = 0;  /* no landing pad */
			else if (action == 0)
				ret.type = CLEANUP;
			else if (*(actiontab + action) == 0)
				ret.type = CATCH;
			else
				ret.type = CLEANUP | CATCH;
			ret.addr = (void*)(lpad + lpstart);
			return ret;
		}
	}

	/* Reaching here is not expected; if ip is not found in the
	 * call-site table, terminate the program */
	ret.type = CATCH;
	ret.addr = NULL;
	return ret;
}

static void ATTR_NORETURN
terminate(struct _Unwind_Context *context, void *exnobj)
{
	char *ip = (void*)_Unwind_GetIP(context);
	char *start = (void*)_Unwind_GetRegionStart(context);
	char *lsda = (void*)_Unwind_GetLanguageSpecificData(context);
	sml_error(0, "*** ip %p (%p+%lu) is not found in exception table at %p",
		  ip, start, ip - start, lsda);
	sml_backtrace();
	if (exnobj)
		uncaught_exception(exnobj);
	else
		abort();
}

_Unwind_Reason_Code
sml_personality(int version, _Unwind_Action actions, uint64_t exnclass,
		struct _Unwind_Exception *ue, struct _Unwind_Context *context)
{
	struct landing_pad lpad;
	void *ret1, *ret2;

	if (version != 1)
		return _URC_FATAL_PHASE1_ERROR;

	if (actions & _UA_SEARCH_PHASE) {
		lpad = search_lpad(context);
		if (lpad.type & CATCH) {
			if (exnclass == EXNCLASS_SMLSHARP)
				UE_TO_EXCEPTION(ue)->handler_addr = lpad.addr;
			return _URC_HANDLER_FOUND;
		}
		if ((lpad.type & CLEANUP) && exnclass == EXNCLASS_SMLSHARP)
			UE_TO_EXCEPTION(ue)->num_cleanup++;
		return _URC_CONTINUE_UNWIND;
	}

	if (!(actions & _UA_CLEANUP_PHASE))
		return _URC_FATAL_PHASE2_ERROR;

	if (actions & _UA_HANDLER_FRAME) {
		/* Unwinding is completed. */
		if (exnclass == EXNCLASS_SMLSHARP) {
			lpad.addr = UE_TO_EXCEPTION(ue)->handler_addr;
			ret1 = NULL;
			ret2 = UE_TO_EXCEPTION(ue);
		} else {
			lpad = search_lpad(context);
			ret1 = NULL;
			ret2 = NULL;
			_Unwind_DeleteException(ue);
		}
	} else {
		/* If no cleanup is found during SEARCH phase, no need to
		 * search for a cleanup landing pad. */
		if (exnclass == EXNCLASS_SMLSHARP
		    && UE_TO_EXCEPTION(ue)->num_cleanup == 0)
			return _URC_CONTINUE_UNWIND;

		lpad = search_lpad(context);
		if (!(lpad.type & CLEANUP)) {
			assert(lpad.type == 0);
			return _URC_CONTINUE_UNWIND;
		}

		if (exnclass == EXNCLASS_SMLSHARP) {
			UE_TO_EXCEPTION(ue)->num_cleanup--;
			ret1 = ue;
			ret2 = UE_TO_EXCEPTION(ue);
		} else {
			ret1 = ue;
			ret2 = NULL;
		}
	}

	/* We are going back to SML# code through a landing pad.
	 * Two pointers are passed to SML# code:
	 * "ret1" for a pointer to struct _Unwind_Exception and
	 * "ret2" for a pointer to struct exception.
	 * "ret1" is NULL when unwinding is finished.
	 * "ret2" is NULL if the exception is a foreign exception.
	 * Note that "ret2" is allocated in SML# heap; the user code
	 * must save it from garbage collection.
	 * Use sml_save_exn to keep "ret1" alive during cleanup.
	 */

	if (!lpad.addr)
		terminate(context, ret2);

	_Unwind_SetIP(context, (uintptr_t)lpad.addr);
	_Unwind_SetGR(context, __builtin_eh_return_data_regno(0),
		      __builtin_extend_pointer(ret1));
	_Unwind_SetGR(context, __builtin_eh_return_data_regno(1),
		      __builtin_extend_pointer(ret2));
	return _URC_INSTALL_CONTEXT;
}
