# clear implicit rules
.SUFFIXES:

SMLSHARP = smlsharp
SMLFLAGS = -O2
SMLFORMAT = smlformat
SMLYACC = smlyacc
SMLLEX = smllex
LIBS =

all: CompletionsGenerator

smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.sml: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.sml
	$(SMLFORMAT) --output=$@ --separate=AbsynTyFormatter $<
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.sml: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.sml
	$(SMLFORMAT) --output=$@ --separate=AbsynConstFormatter $<
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.sml: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.sml
	$(SMLFORMAT) --output=$@ --separate=AbsynSQLFormatter $<
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.sml: \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.sml
	$(SMLFORMAT) --output=$@ --separate=AbsynFormatter $<
%.ppg.sml: %.ppg
	$(SMLFORMAT) --output=$@ $<
%.grm.sml: %.grm
	$(SMLYACC) -s -p $< $<
%.lex.sml: %.lex
	$(SMLLEX) -o $@ $<
smlsharp/src/config/main/SQLConfig.sml: \
 smlsharp/src/config/main/SQLConfig.sml.in
	sed -e 's"%DLLEXT%"$(DLLEXT)"' $< > $@

clean:
	rm -f CompletionsGenerator CompletionsGenerator.o \
 CompletionsGenerator.o \
 smlsharp/src/basis/main/Array.o \
 smlsharp/src/basis/main/ArraySlice.o \
 smlsharp/src/basis/main/Bool.o \
 smlsharp/src/basis/main/Byte.o \
 smlsharp/src/basis/main/Char.o \
 smlsharp/src/basis/main/CharArray.o \
 smlsharp/src/basis/main/CharArraySlice.o \
 smlsharp/src/basis/main/CharVector.o \
 smlsharp/src/basis/main/CharVectorSlice.o \
 smlsharp/src/basis/main/CommandLine.o \
 smlsharp/src/basis/main/General.o \
 smlsharp/src/basis/main/IEEEReal.o \
 smlsharp/src/basis/main/IO.o \
 smlsharp/src/basis/main/Int16.o \
 smlsharp/src/basis/main/Int32.o \
 smlsharp/src/basis/main/Int64.o \
 smlsharp/src/basis/main/Int8.o \
 smlsharp/src/basis/main/IntInf.o \
 smlsharp/src/basis/main/List.o \
 smlsharp/src/basis/main/ListPair.o \
 smlsharp/src/basis/main/OS.o \
 smlsharp/src/basis/main/Option.o \
 smlsharp/src/basis/main/Real32.o \
 smlsharp/src/basis/main/Real64.o \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.o \
 smlsharp/src/basis/main/SMLSharp_OSIO.o \
 smlsharp/src/basis/main/SMLSharp_OSProcess.o \
 smlsharp/src/basis/main/SMLSharp_RealClass.o \
 smlsharp/src/basis/main/SMLSharp_Runtime.o \
 smlsharp/src/basis/main/SMLSharp_ScanChar.o \
 smlsharp/src/basis/main/String.o \
 smlsharp/src/basis/main/StringCvt.o \
 smlsharp/src/basis/main/Substring.o \
 smlsharp/src/basis/main/Text.o \
 smlsharp/src/basis/main/Time.o \
 smlsharp/src/basis/main/Timer.o \
 smlsharp/src/basis/main/Vector.o \
 smlsharp/src/basis/main/VectorSlice.o \
 smlsharp/src/basis/main/Word16.o \
 smlsharp/src/basis/main/Word32.o \
 smlsharp/src/basis/main/Word64.o \
 smlsharp/src/basis/main/Word8.o \
 smlsharp/src/basis/main/Word8Array.o \
 smlsharp/src/basis/main/Word8ArraySlice.o \
 smlsharp/src/basis/main/Word8Vector.o \
 smlsharp/src/basis/main/Word8VectorSlice.o \
 smlsharp/src/basis/main/toplevel.o \
 smlsharp/src/compiler/compilePhases/parser/main/Parser.o \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.o \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.sml \
 smlsharp/src/compiler/compilePhases/parser/main/SMLSharpParser.o \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.desc \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.o \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.sml \
 smlsharp/src/compiler/compilePhases/parser/main/iml.lex.o \
 smlsharp/src/compiler/compilePhases/parser/main/iml.lex.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.o \
 smlsharp/src/compiler/data/control/main/Control.o \
 smlsharp/src/compiler/data/control/main/PrintControl.o \
 smlsharp/src/compiler/data/symbols/main/Loc.o \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.o \
 smlsharp/src/compiler/data/symbols/main/Symbol.o \
 smlsharp/src/compiler/extensions/debug/main/Bug.o \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.o \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.sml \
 smlsharp/src/compiler/libs/env/main/SEnv.o \
 smlsharp/src/compiler/libs/env/main/SOrd.o \
 smlsharp/src/compiler/libs/env/main/SSet.o \
 smlsharp/src/compiler/libs/toolchain/main/Filename.o \
 smlsharp/src/ml-yacc/lib/lrtable.o \
 smlsharp/src/ml-yacc/lib/parser2.o \
 smlsharp/src/ml-yacc/lib/stream.o \
 smlsharp/src/smlformat/formatlib/main/AssocResolver.o \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.o \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.o \
 smlsharp/src/smlformat/formatlib/main/FormatExpressionTypes.o \
 smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.o \
 smlsharp/src/smlformat/formatlib/main/PreProcessor.o \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter.o \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter2.o \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.o \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.o \
 smlsharp/src/smlformat/formatlib/main/Truncator.o \
 smlsharp/src/smlnj-lib/Util/binary-map-fn.o \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.o \
 smlsharp/src/smlnj-lib/Util/lib-base.o \
 smlsharp/src/smlnj-lib/Util/parser-comb.o \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.o \
 smlsharp/src/smlnj/Basis/IO/bin-io.o \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.o \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.o \
 smlsharp/src/smlnj/Basis/IO/text-io.o \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.o \
 smlsharp/src/smlnj/Basis/Posix/posix-io.o \
 smlsharp/src/smlnj/Basis/Unix/os-path.o \
 smlsharp/src/smlnj/Basis/Unix/posix-bin-prim-io.o \
 smlsharp/src/smlnj/Basis/Unix/posix-text-prim-io.o \
 smlsharp/src/smlnj/Basis/date.o

# ===== Generated by smlsharp -MMm CompletionGenerator.smi =====

CompletionsGenerator: smlsharp/src/basis/main/General.smi \
 smlsharp/src/basis/main/StringCvt.smi smlsharp/src/basis/main/List.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/SMLSharp_RealClass.smi \
 smlsharp/src/basis/main/Real64.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/Word32.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Word8.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharArraySlice.smi smlsharp/src/basis/main/Byte.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/Posix/posix-io.smi \
 smlsharp/src/smlnj/Basis/Unix/posix-bin-prim-io.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/smlnj/Basis/date.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Real32.smi smlsharp/src/basis/main/Int64.smi \
 smlsharp/src/smlnj/Basis/Unix/posix-text-prim-io.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word64.smi smlsharp/src/basis/main/toplevel.smi \
 smlsharp/src/basis/main/ARRAY.sig smlsharp/src/basis/main/ARRAY_SLICE.sig \
 smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlnj-lib/Util/parser-comb-sig.sml \
 smlsharp/src/smlnj-lib/Util/parser-comb.smi \
 smlsharp/src/smlformat/formatlib/main/FORMAT_EXPRESSION.sig \
 smlsharp/src/smlformat/formatlib/main/FormatExpressionTypes.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/AssocResolver.smi \
 smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter.smi \
 smlsharp/src/smlformat/formatlib/main/Truncator.smi \
 smlsharp/src/smlformat/formatlib/main/PreProcessor.smi \
 smlsharp/src/smlformat/formatlib/main/BASIC_FORMATTERS.sig \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter2.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi smlsharp/src/smlnj-lib/Util/lib-base-sig.sml \
 smlsharp/src/smlnj-lib/Util/lib-base.smi \
 smlsharp/src/smlnj-lib/Util/ord-key-sig.sml \
 smlsharp/src/smlnj-lib/Util/ord-map-sig.sml \
 smlsharp/src/smlnj-lib/Util/binary-map-fn.smi \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi \
 smlsharp/src/smlnj-lib/Util/ord-set-sig.sml \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/compiler/libs/env/main/SSet.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/extensions/usererror/main/USER_ERROR.sig \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/data/control/main/PrintControl.smi \
 smlsharp/src/compiler/data/control/main/Control.smi \
 smlsharp/src/ml-yacc/lib/base.sig smlsharp/src/ml-yacc/lib/lrtable.smi \
 smlsharp/src/ml-yacc/lib/stream.smi smlsharp/src/ml-yacc/lib/parser2.smi \
 smlsharp/src/ml-yacc-lib.smi \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.smi \
 smlsharp/src/compiler/compilePhases/parser/main/iml.lex.smi \
 smlsharp/src/compiler/compilePhases/parser/main/SMLSharpParser.smi \
 smlsharp/src/compiler/compilePhases/parser/main/Parser.smi \
 CompletionsGenerator.smi smlsharp/src/basis/main/General.o \
 smlsharp/src/basis/main/StringCvt.o smlsharp/src/basis/main/List.o \
 smlsharp/src/basis/main/SMLSharp_ScanChar.o smlsharp/src/basis/main/Char.o \
 smlsharp/src/basis/main/CharVector.o smlsharp/src/basis/main/Substring.o \
 smlsharp/src/basis/main/String.o smlsharp/src/basis/main/IntInf.o \
 smlsharp/src/basis/main/Int32.o smlsharp/src/basis/main/SMLSharp_Runtime.o \
 smlsharp/src/basis/main/IEEEReal.o \
 smlsharp/src/basis/main/SMLSharp_RealClass.o smlsharp/src/basis/main/Real64.o \
 smlsharp/src/basis/main/Time.o smlsharp/src/basis/main/Int8.o \
 smlsharp/src/basis/main/Int16.o smlsharp/src/basis/main/Word8VectorSlice.o \
 smlsharp/src/basis/main/Word8ArraySlice.o smlsharp/src/basis/main/Array.o \
 smlsharp/src/basis/main/VectorSlice.o smlsharp/src/basis/main/ArraySlice.o \
 smlsharp/src/basis/main/Word8Vector.o smlsharp/src/basis/main/IO.o \
 smlsharp/src/basis/main/Word8Array.o smlsharp/src/basis/main/SMLSharp_OSIO.o \
 smlsharp/src/basis/main/Bool.o smlsharp/src/smlnj/Basis/OS/os-path-fn.o \
 smlsharp/src/smlnj/Basis/Unix/os-path.o \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.o smlsharp/src/basis/main/Word32.o \
 smlsharp/src/basis/main/SMLSharp_OSProcess.o smlsharp/src/basis/main/OS.o \
 smlsharp/src/basis/main/Option.o smlsharp/src/basis/main/Word8.o \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.o \
 smlsharp/src/basis/main/CharVectorSlice.o smlsharp/src/basis/main/CharArray.o \
 smlsharp/src/basis/main/CharArraySlice.o smlsharp/src/basis/main/Byte.o \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.o \
 smlsharp/src/smlnj/Basis/Posix/posix-io.o \
 smlsharp/src/smlnj/Basis/Unix/posix-bin-prim-io.o \
 smlsharp/src/smlnj/Basis/IO/bin-io.o smlsharp/src/basis/main/CommandLine.o \
 smlsharp/src/basis/main/Vector.o smlsharp/src/smlnj/Basis/date.o \
 smlsharp/src/basis/main/ListPair.o smlsharp/src/basis/main/Real32.o \
 smlsharp/src/basis/main/Int64.o \
 smlsharp/src/smlnj/Basis/Unix/posix-text-prim-io.o \
 smlsharp/src/smlnj/Basis/IO/text-io.o smlsharp/src/basis/main/Text.o \
 smlsharp/src/basis/main/Timer.o smlsharp/src/basis/main/Word16.o \
 smlsharp/src/basis/main/Word64.o smlsharp/src/basis/main/toplevel.o \
 smlsharp/src/smlnj-lib/Util/parser-comb.o \
 smlsharp/src/smlformat/formatlib/main/FormatExpressionTypes.o \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.o \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.o \
 smlsharp/src/smlformat/formatlib/main/AssocResolver.o \
 smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.o \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter.o \
 smlsharp/src/smlformat/formatlib/main/Truncator.o \
 smlsharp/src/smlformat/formatlib/main/PreProcessor.o \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.o \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter2.o \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.o \
 smlsharp/src/smlnj-lib/Util/lib-base.o \
 smlsharp/src/smlnj-lib/Util/binary-map-fn.o \
 smlsharp/src/compiler/libs/env/main/SOrd.o \
 smlsharp/src/compiler/libs/env/main/SEnv.o \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.o \
 smlsharp/src/compiler/libs/env/main/SSet.o \
 smlsharp/src/compiler/libs/toolchain/main/Filename.o \
 smlsharp/src/compiler/data/symbols/main/Loc.o \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.o \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.o \
 smlsharp/src/compiler/data/symbols/main/Symbol.o \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.o \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.o \
 smlsharp/src/compiler/extensions/debug/main/Bug.o \
 smlsharp/src/compiler/data/control/main/PrintControl.o \
 smlsharp/src/compiler/data/control/main/Control.o \
 smlsharp/src/ml-yacc/lib/lrtable.o smlsharp/src/ml-yacc/lib/stream.o \
 smlsharp/src/ml-yacc/lib/parser2.o \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.o \
 smlsharp/src/compiler/compilePhases/parser/main/iml.lex.o \
 smlsharp/src/compiler/compilePhases/parser/main/SMLSharpParser.o \
 smlsharp/src/compiler/compilePhases/parser/main/Parser.o CompletionsGenerator.o
	$(SMLSHARP) $(LDFLAGS) -o CompletionsGenerator \
 CompletionsGenerator.smi $(LIBS)
smlsharp/src/basis/main/General.o: smlsharp/src/basis/main/General.sml \
 smlsharp/src/basis/main/General.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/General.o -c \
 smlsharp/src/basis/main/General.sml
smlsharp/src/basis/main/StringCvt.o: smlsharp/src/basis/main/StringCvt.sml \
 smlsharp/src/basis/main/StringCvt.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/StringCvt.o -c \
 smlsharp/src/basis/main/StringCvt.sml
smlsharp/src/basis/main/List.o: smlsharp/src/basis/main/List.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/List.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/List.o -c \
 smlsharp/src/basis/main/List.sml
smlsharp/src/basis/main/SMLSharp_ScanChar.o: \
 smlsharp/src/basis/main/SMLSharp_ScanChar.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/List.smi \
 smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/SMLSharp_ScanChar.o \
 -c smlsharp/src/basis/main/SMLSharp_ScanChar.sml
smlsharp/src/basis/main/Char.o: smlsharp/src/basis/main/Char.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi smlsharp/src/basis/main/Char.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Char.o -c \
 smlsharp/src/basis/main/Char.sml
smlsharp/src/basis/main/CharVector.o: smlsharp/src/basis/main/CharVector.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Array_common.sml \
 smlsharp/src/basis/main/CharVector.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/CharVector.o -c \
 smlsharp/src/basis/main/CharVector.sml
smlsharp/src/basis/main/Substring.o: smlsharp/src/basis/main/Substring.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Slice_common.sml \
 smlsharp/src/basis/main/Substring.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Substring.o -c \
 smlsharp/src/basis/main/Substring.sml
smlsharp/src/basis/main/String.o: smlsharp/src/basis/main/String.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/String.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/String.o -c \
 smlsharp/src/basis/main/String.sml
smlsharp/src/basis/main/IntInf.o: smlsharp/src/basis/main/IntInf.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/IntInf.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/IntInf.o -c \
 smlsharp/src/basis/main/IntInf.sml
smlsharp/src/basis/main/Int32.o: smlsharp/src/basis/main/Int32.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Int_common.sml smlsharp/src/basis/main/Int32.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Int32.o -c \
 smlsharp/src/basis/main/Int32.sml
smlsharp/src/basis/main/SMLSharp_Runtime.o: \
 smlsharp/src/basis/main/SMLSharp_Runtime.sml \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/SMLSharp_Runtime.o \
 -c smlsharp/src/basis/main/SMLSharp_Runtime.sml
smlsharp/src/basis/main/IEEEReal.o: smlsharp/src/basis/main/IEEEReal.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/Int32.smi smlsharp/src/basis/main/List.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/IEEEReal.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/IEEEReal.o -c \
 smlsharp/src/basis/main/IEEEReal.sml
smlsharp/src/basis/main/SMLSharp_RealClass.o: \
 smlsharp/src/basis/main/SMLSharp_RealClass.sml \
 smlsharp/src/basis/main/StringCvt.smi smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/SMLSharp_RealClass.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/basis/main/SMLSharp_RealClass.o -c \
 smlsharp/src/basis/main/SMLSharp_RealClass.sml
smlsharp/src/basis/main/Real64.o: smlsharp/src/basis/main/Real64.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/SMLSharp_RealClass.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Real64.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Real64.o -c \
 smlsharp/src/basis/main/Real64.sml
smlsharp/src/basis/main/Time.o: smlsharp/src/basis/main/Time.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Time.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Time.o -c \
 smlsharp/src/basis/main/Time.sml
smlsharp/src/basis/main/Int8.o: smlsharp/src/basis/main/Int8.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Int_common.sml smlsharp/src/basis/main/Int8.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Int8.o -c \
 smlsharp/src/basis/main/Int8.sml
smlsharp/src/basis/main/Int16.o: smlsharp/src/basis/main/Int16.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Int_common.sml smlsharp/src/basis/main/Int16.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Int16.o -c \
 smlsharp/src/basis/main/Int16.sml
smlsharp/src/basis/main/Word8VectorSlice.o: \
 smlsharp/src/basis/main/Word8VectorSlice.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Slice_common.sml \
 smlsharp/src/basis/main/Word8VectorSlice.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Word8VectorSlice.o \
 -c smlsharp/src/basis/main/Word8VectorSlice.sml
smlsharp/src/basis/main/Word8ArraySlice.o: \
 smlsharp/src/basis/main/Word8ArraySlice.sml \
 smlsharp/src/basis/main/General.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Slice_common.sml \
 smlsharp/src/basis/main/Word8ArraySlice.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Word8ArraySlice.o \
 -c smlsharp/src/basis/main/Word8ArraySlice.sml
smlsharp/src/basis/main/Array.o: smlsharp/src/basis/main/Array.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Array_common.sml \
 smlsharp/src/basis/main/Array.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Array.o -c \
 smlsharp/src/basis/main/Array.sml
smlsharp/src/basis/main/VectorSlice.o: smlsharp/src/basis/main/VectorSlice.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Slice_common.sml \
 smlsharp/src/basis/main/VectorSlice.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/VectorSlice.o -c \
 smlsharp/src/basis/main/VectorSlice.sml
smlsharp/src/basis/main/ArraySlice.o: smlsharp/src/basis/main/ArraySlice.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/Slice_common.sml smlsharp/src/basis/main/ArraySlice.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/ArraySlice.o -c \
 smlsharp/src/basis/main/ArraySlice.sml
smlsharp/src/basis/main/Word8Vector.o: smlsharp/src/basis/main/Word8Vector.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Array_common.sml \
 smlsharp/src/basis/main/Word8Vector.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Word8Vector.o -c \
 smlsharp/src/basis/main/Word8Vector.sml
smlsharp/src/basis/main/IO.o: smlsharp/src/basis/main/IO.sml \
 smlsharp/src/basis/main/IO.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/IO.o -c \
 smlsharp/src/basis/main/IO.sml
smlsharp/src/basis/main/Word8Array.o: smlsharp/src/basis/main/Word8Array.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Array_common.sml \
 smlsharp/src/basis/main/Word8Array.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Word8Array.o -c \
 smlsharp/src/basis/main/Word8Array.sml
smlsharp/src/basis/main/SMLSharp_OSIO.o: \
 smlsharp/src/basis/main/SMLSharp_OSIO.sml smlsharp/src/basis/main/General.smi \
 smlsharp/src/basis/main/StringCvt.smi smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/Time.smi smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/SMLSharp_OSIO.o -c \
 smlsharp/src/basis/main/SMLSharp_OSIO.sml
smlsharp/src/basis/main/Bool.o: smlsharp/src/basis/main/Bool.sml \
 smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi smlsharp/src/basis/main/Bool.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Bool.o -c \
 smlsharp/src/basis/main/Bool.sml
smlsharp/src/smlnj/Basis/OS/os-path-fn.o: \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/List.smi \
 smlsharp/src/basis/main/StringCvt.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj/Basis/OS/os-path-fn.o -c \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.sml
smlsharp/src/smlnj/Basis/Unix/os-path.o: \
 smlsharp/src/smlnj/Basis/Unix/os-path.sml smlsharp/src/basis/main/General.smi \
 smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/String.smi smlsharp/src/smlnj/Basis/Unix/os-path.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj/Basis/Unix/os-path.o -c \
 smlsharp/src/smlnj/Basis/Unix/os-path.sml
smlsharp/src/basis/main/SMLSharp_OSFileSys.o: \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/Real64.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.o -c \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.sml
smlsharp/src/basis/main/Word32.o: smlsharp/src/basis/main/Word32.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Word_common.sml smlsharp/src/basis/main/Word32.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Word32.o -c \
 smlsharp/src/basis/main/Word32.sml
smlsharp/src/basis/main/SMLSharp_OSProcess.o: \
 smlsharp/src/basis/main/SMLSharp_OSProcess.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/Time.smi smlsharp/src/basis/main/Word32.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/basis/main/SMLSharp_OSProcess.o -c \
 smlsharp/src/basis/main/SMLSharp_OSProcess.sml
smlsharp/src/basis/main/OS.o: smlsharp/src/basis/main/OS.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/Time.smi smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/OS.o -c \
 smlsharp/src/basis/main/OS.sml
smlsharp/src/basis/main/Option.o: smlsharp/src/basis/main/Option.sml \
 smlsharp/src/basis/main/Option.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Option.o -c \
 smlsharp/src/basis/main/Option.sml
smlsharp/src/basis/main/Word8.o: smlsharp/src/basis/main/Word8.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Word_common.sml smlsharp/src/basis/main/Word8.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Word8.o -c \
 smlsharp/src/basis/main/Word8.sml
smlsharp/src/smlnj/Basis/IO/prim-io-bin.o: \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Word8Vector.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/StringCvt.smi smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/Int32.smi smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/Real64.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/basis/main/IO.smi smlsharp/src/basis/main/Option.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj/Basis/IO/prim-io-bin.o \
 -c smlsharp/src/smlnj/Basis/IO/prim-io-bin.sml
smlsharp/src/basis/main/CharVectorSlice.o: \
 smlsharp/src/basis/main/CharVectorSlice.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Slice_common.sml \
 smlsharp/src/basis/main/CharVectorSlice.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/CharVectorSlice.o \
 -c smlsharp/src/basis/main/CharVectorSlice.sml
smlsharp/src/basis/main/CharArray.o: smlsharp/src/basis/main/CharArray.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Array_common.sml \
 smlsharp/src/basis/main/CharArray.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/CharArray.o -c \
 smlsharp/src/basis/main/CharArray.sml
smlsharp/src/basis/main/CharArraySlice.o: \
 smlsharp/src/basis/main/CharArraySlice.sml \
 smlsharp/src/basis/main/General.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/Slice_common.sml \
 smlsharp/src/basis/main/CharArraySlice.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/CharArraySlice.o -c \
 smlsharp/src/basis/main/CharArraySlice.sml
smlsharp/src/basis/main/Byte.o: smlsharp/src/basis/main/Byte.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi smlsharp/src/basis/main/Byte.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Byte.o -c \
 smlsharp/src/basis/main/Byte.sml
smlsharp/src/smlnj/Basis/IO/prim-io-text.o: \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Option.smi \
 smlsharp/src/basis/main/StringCvt.smi smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/Int32.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/Time.smi smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/basis/main/IO.smi smlsharp/src/smlnj/Basis/IO/prim-io-text.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj/Basis/IO/prim-io-text.o \
 -c smlsharp/src/smlnj/Basis/IO/prim-io-text.sml
smlsharp/src/smlnj/Basis/Posix/posix-io.o: \
 smlsharp/src/smlnj/Basis/Posix/posix-io.sml smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Byte.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/Time.smi smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/Posix/posix-io.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj/Basis/Posix/posix-io.o \
 -c smlsharp/src/smlnj/Basis/Posix/posix-io.sml
smlsharp/src/smlnj/Basis/Unix/posix-bin-prim-io.o: \
 smlsharp/src/smlnj/Basis/Unix/posix-bin-prim-io.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/Time.smi smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/basis/main/Word8Vector.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/Posix/posix-io.smi \
 smlsharp/src/smlnj/Basis/Unix/posix-bin-prim-io.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlnj/Basis/Unix/posix-bin-prim-io.o -c \
 smlsharp/src/smlnj/Basis/Unix/posix-bin-prim-io.sml
smlsharp/src/smlnj/Basis/IO/bin-io.o: smlsharp/src/smlnj/Basis/IO/bin-io.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/Real64.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/Word8Vector.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/IO.smi smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/Posix/posix-io.smi \
 smlsharp/src/smlnj/Basis/Unix/posix-bin-prim-io.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj/Basis/IO/bin-io.o -c \
 smlsharp/src/smlnj/Basis/IO/bin-io.sml
smlsharp/src/basis/main/CommandLine.o: smlsharp/src/basis/main/CommandLine.sml \
 smlsharp/src/basis/main/CommandLine.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/CommandLine.o -c \
 smlsharp/src/basis/main/CommandLine.sml
smlsharp/src/basis/main/Vector.o: smlsharp/src/basis/main/Vector.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/Array_common.sml \
 smlsharp/src/basis/main/Vector.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Vector.o -c \
 smlsharp/src/basis/main/Vector.sml
smlsharp/src/smlnj/Basis/date.o: smlsharp/src/smlnj/Basis/date.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Array.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/List.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/Real64.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi smlsharp/src/basis/main/Word32.smi \
 smlsharp/src/basis/main/CharArray.smi smlsharp/src/smlnj/Basis/date.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj/Basis/date.o -c \
 smlsharp/src/smlnj/Basis/date.sml
smlsharp/src/basis/main/ListPair.o: smlsharp/src/basis/main/ListPair.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/List.smi \
 smlsharp/src/basis/main/ListPair.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/ListPair.o -c \
 smlsharp/src/basis/main/ListPair.sml
smlsharp/src/basis/main/Real32.o: smlsharp/src/basis/main/Real32.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/SMLSharp_RealClass.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi smlsharp/src/basis/main/Real32.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Real32.o -c \
 smlsharp/src/basis/main/Real32.sml
smlsharp/src/basis/main/Int64.o: smlsharp/src/basis/main/Int64.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Int_common.sml smlsharp/src/basis/main/Int64.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Int64.o -c \
 smlsharp/src/basis/main/Int64.sml
smlsharp/src/smlnj/Basis/Unix/posix-text-prim-io.o: \
 smlsharp/src/smlnj/Basis/Unix/posix-text-prim-io.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/CharArray.smi smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/Real64.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/basis/main/Word8Vector.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/Posix/posix-io.smi \
 smlsharp/src/smlnj/Basis/Unix/posix-text-prim-io.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlnj/Basis/Unix/posix-text-prim-io.o -c \
 smlsharp/src/smlnj/Basis/Unix/posix-text-prim-io.sml
smlsharp/src/smlnj/Basis/IO/text-io.o: smlsharp/src/smlnj/Basis/IO/text-io.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/StringCvt.smi smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/Int32.smi smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/Real64.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/Substring.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/basis/main/Option.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/basis/main/Word8Vector.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/Posix/posix-io.smi \
 smlsharp/src/smlnj/Basis/Unix/posix-text-prim-io.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj/Basis/IO/text-io.o -c \
 smlsharp/src/smlnj/Basis/IO/text-io.sml
smlsharp/src/basis/main/Text.o: smlsharp/src/basis/main/Text.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Text.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Text.o -c \
 smlsharp/src/basis/main/Text.sml
smlsharp/src/basis/main/Timer.o: smlsharp/src/basis/main/Timer.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/Time.smi smlsharp/src/basis/main/Timer.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Timer.o -c \
 smlsharp/src/basis/main/Timer.sml
smlsharp/src/basis/main/Word16.o: smlsharp/src/basis/main/Word16.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Word_common.sml smlsharp/src/basis/main/Word16.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Word16.o -c \
 smlsharp/src/basis/main/Word16.sml
smlsharp/src/basis/main/Word64.o: smlsharp/src/basis/main/Word64.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Word_common.sml smlsharp/src/basis/main/Word64.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/Word64.o -c \
 smlsharp/src/basis/main/Word64.sml
smlsharp/src/basis/main/toplevel.o: smlsharp/src/basis/main/toplevel.sml \
 smlsharp/src/basis/main/StringCvt.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/General.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/Option.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/CharVector.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/IO.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharArraySlice.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/toplevel.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/basis/main/toplevel.o -c \
 smlsharp/src/basis/main/toplevel.sml
smlsharp/src/smlnj-lib/Util/parser-comb.o: \
 smlsharp/src/smlnj-lib/Util/parser-comb.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlnj-lib/Util/parser-comb-sig.sml \
 smlsharp/src/smlnj-lib/Util/parser-comb.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj-lib/Util/parser-comb.o \
 -c smlsharp/src/smlnj-lib/Util/parser-comb.sml
smlsharp/src/smlformat/formatlib/main/FormatExpressionTypes.o: \
 smlsharp/src/smlformat/formatlib/main/FormatExpressionTypes.sml \
 smlsharp/src/smlformat/formatlib/main/FormatExpressionTypes.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/FormatExpressionTypes.o -c \
 smlsharp/src/smlformat/formatlib/main/FormatExpressionTypes.sml
smlsharp/src/smlformat/formatlib/main/FormatExpression.o: \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlnj-lib/Util/parser-comb.smi \
 smlsharp/src/smlformat/formatlib/main/FORMAT_EXPRESSION.sig \
 smlsharp/src/smlformat/formatlib/main/FormatExpressionTypes.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.o -c \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.sml
smlsharp/src/smlformat/formatlib/main/PrinterParameter.o: \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.o -c \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.sml
smlsharp/src/smlformat/formatlib/main/AssocResolver.o: \
 smlsharp/src/smlformat/formatlib/main/AssocResolver.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/AssocResolver.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/AssocResolver.o -c \
 smlsharp/src/smlformat/formatlib/main/AssocResolver.sml
smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.o: \
 smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.o -c \
 smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.sml
smlsharp/src/smlformat/formatlib/main/PrettyPrinter.o: \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter.o -c \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter.sml
smlsharp/src/smlformat/formatlib/main/Truncator.o: \
 smlsharp/src/smlformat/formatlib/main/Truncator.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/Truncator.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/Truncator.o -c \
 smlsharp/src/smlformat/formatlib/main/Truncator.sml
smlsharp/src/smlformat/formatlib/main/PreProcessor.o: \
 smlsharp/src/smlformat/formatlib/main/PreProcessor.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/PreProcessor.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/PreProcessor.o -c \
 smlsharp/src/smlformat/formatlib/main/PreProcessor.sml
smlsharp/src/smlformat/formatlib/main/BasicFormatters.o: \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/BASIC_FORMATTERS.sig \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.o -c \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.sml
smlsharp/src/smlformat/formatlib/main/PrettyPrinter2.o: \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter2.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter2.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter2.o -c \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter2.sml
smlsharp/src/smlformat/formatlib/main/SMLFormat.o: \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/AssocResolver.smi \
 smlsharp/src/smlformat/formatlib/main/PreProcessedExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter.smi \
 smlsharp/src/smlformat/formatlib/main/Truncator.smi \
 smlsharp/src/smlformat/formatlib/main/PreProcessor.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/PrettyPrinter2.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.o -c \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.sml
smlsharp/src/smlnj-lib/Util/lib-base.o: \
 smlsharp/src/smlnj-lib/Util/lib-base.sml smlsharp/src/basis/main/General.smi \
 smlsharp/src/basis/main/StringCvt.smi smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/Real64.smi smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/Time.smi smlsharp/src/basis/main/Int8.smi \
 smlsharp/src/basis/main/Int16.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlnj-lib/Util/lib-base-sig.sml \
 smlsharp/src/smlnj-lib/Util/lib-base.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj-lib/Util/lib-base.o -c \
 smlsharp/src/smlnj-lib/Util/lib-base.sml
smlsharp/src/smlnj-lib/Util/binary-map-fn.o: \
 smlsharp/src/smlnj-lib/Util/binary-map-fn.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlnj-lib/Util/lib-base.smi \
 smlsharp/src/smlnj-lib/Util/ord-key-sig.sml \
 smlsharp/src/smlnj-lib/Util/ord-map-sig.sml \
 smlsharp/src/smlnj-lib/Util/binary-map-fn.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj-lib/Util/binary-map-fn.o \
 -c smlsharp/src/smlnj-lib/Util/binary-map-fn.sml
smlsharp/src/compiler/libs/env/main/SOrd.o: \
 smlsharp/src/compiler/libs/env/main/SOrd.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/compiler/libs/env/main/SOrd.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/compiler/libs/env/main/SOrd.o \
 -c smlsharp/src/compiler/libs/env/main/SOrd.sml
smlsharp/src/compiler/libs/env/main/SEnv.o: \
 smlsharp/src/compiler/libs/env/main/SEnv.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlnj-lib/Util/binary-map-fn.smi \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/compiler/libs/env/main/SEnv.o \
 -c smlsharp/src/compiler/libs/env/main/SEnv.sml
smlsharp/src/smlnj-lib/Util/binary-set-fn.o: \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlnj-lib/Util/lib-base.smi \
 smlsharp/src/smlnj-lib/Util/ord-key-sig.sml \
 smlsharp/src/smlnj-lib/Util/ord-set-sig.sml \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/smlnj-lib/Util/binary-set-fn.o \
 -c smlsharp/src/smlnj-lib/Util/binary-set-fn.sml
smlsharp/src/compiler/libs/env/main/SSet.o: \
 smlsharp/src/compiler/libs/env/main/SSet.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SSet.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/compiler/libs/env/main/SSet.o \
 -c smlsharp/src/compiler/libs/env/main/SSet.sml
smlsharp/src/compiler/libs/toolchain/main/Filename.o: \
 smlsharp/src/compiler/libs/toolchain/main/Filename.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi smlsharp/src/smlnj-lib/Util/binary-map-fn.smi \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/compiler/libs/env/main/SSet.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/libs/toolchain/main/Filename.o -c \
 smlsharp/src/compiler/libs/toolchain/main/Filename.sml
smlsharp/src/compiler/data/symbols/main/Loc.o: \
 smlsharp/src/compiler/data/symbols/main/Loc.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/data/symbols/main/Loc.o -c \
 smlsharp/src/compiler/data/symbols/main/Loc.sml
smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.o: \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/extensions/usererror/main/USER_ERROR.sig \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.o -c \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.sml
smlsharp/src/smlnj-lib/Util2/binary-map-fn2.o: \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlnj-lib/Util/lib-base.smi \
 smlsharp/src/smlnj-lib/Util/ord-key-sig.sml \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.o -c \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.sml
smlsharp/src/compiler/data/symbols/main/Symbol.o: \
 smlsharp/src/compiler/data/symbols/main/Symbol.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/data/symbols/main/Symbol.o -c \
 smlsharp/src/compiler/data/symbols/main/Symbol.sml
smlsharp/src/compiler/data/symbols/main/RecordLabel.o: \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.o -c \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.sml
smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.sml
smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.sml
smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.o: \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.o -c \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.sml
smlsharp/src/compiler/extensions/debug/main/Bug.o: \
 smlsharp/src/compiler/extensions/debug/main/Bug.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/extensions/debug/main/Bug.o -c \
 smlsharp/src/compiler/extensions/debug/main/Bug.sml
smlsharp/src/compiler/data/control/main/PrintControl.o: \
 smlsharp/src/compiler/data/control/main/PrintControl.sml \
 smlsharp/src/compiler/data/control/main/PrintControl.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/data/control/main/PrintControl.o -c \
 smlsharp/src/compiler/data/control/main/PrintControl.sml
smlsharp/src/compiler/data/control/main/Control.o: \
 smlsharp/src/compiler/data/control/main/Control.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/data/control/main/PrintControl.smi \
 smlsharp/src/compiler/data/control/main/Control.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/data/control/main/Control.o -c \
 smlsharp/src/compiler/data/control/main/Control.sml
smlsharp/src/ml-yacc/lib/lrtable.o: smlsharp/src/ml-yacc/lib/lrtable.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/ml-yacc/lib/base.sig smlsharp/src/ml-yacc/lib/lrtable.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/ml-yacc/lib/lrtable.o -c \
 smlsharp/src/ml-yacc/lib/lrtable.sml
smlsharp/src/ml-yacc/lib/stream.o: smlsharp/src/ml-yacc/lib/stream.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/ml-yacc/lib/base.sig smlsharp/src/ml-yacc/lib/stream.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/ml-yacc/lib/stream.o -c \
 smlsharp/src/ml-yacc/lib/stream.sml
smlsharp/src/ml-yacc/lib/parser2.o: smlsharp/src/ml-yacc/lib/parser2.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/ml-yacc/lib/base.sig smlsharp/src/ml-yacc/lib/stream.smi \
 smlsharp/src/ml-yacc/lib/lrtable.smi smlsharp/src/ml-yacc/lib/parser2.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/ml-yacc/lib/parser2.o -c \
 smlsharp/src/ml-yacc/lib/parser2.sml
smlsharp/src/compiler/compilePhases/parser/main/iml.grm.o: \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.sml \
 smlsharp/src/ml-yacc/lib/base.sig smlsharp/src/ml-yacc/lib/lrtable.smi \
 smlsharp/src/ml-yacc/lib/stream.smi smlsharp/src/ml-yacc/lib/parser2.smi \
 smlsharp/src/ml-yacc-lib.smi smlsharp/src/basis/main/General.smi \
 smlsharp/src/basis/main/StringCvt.smi smlsharp/src/basis/main/IEEEReal.smi \
 smlsharp/src/basis/main/Real64.smi smlsharp/src/basis/main/IntInf.smi \
 smlsharp/src/basis/main/Time.smi smlsharp/src/basis/main/Int8.smi \
 smlsharp/src/basis/main/Int16.smi smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.o -c \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.sml
smlsharp/src/compiler/compilePhases/parser/main/iml.lex.o: \
 smlsharp/src/compiler/compilePhases/parser/main/iml.lex.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.smi \
 smlsharp/src/compiler/compilePhases/parser/main/iml.lex.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilePhases/parser/main/iml.lex.o -c \
 smlsharp/src/compiler/compilePhases/parser/main/iml.lex.sml
smlsharp/src/compiler/compilePhases/parser/main/SMLSharpParser.o: \
 smlsharp/src/compiler/compilePhases/parser/main/SMLSharpParser.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/data/control/main/PrintControl.smi \
 smlsharp/src/compiler/data/control/main/Control.smi \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/compilePhases/parser/main/iml.grm.smi \
 smlsharp/src/compiler/compilePhases/parser/main/iml.lex.smi \
 smlsharp/src/compiler/compilePhases/parser/main/SMLSharpParser.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilePhases/parser/main/SMLSharpParser.o -c \
 smlsharp/src/compiler/compilePhases/parser/main/SMLSharpParser.sml
smlsharp/src/compiler/compilePhases/parser/main/Parser.o: \
 smlsharp/src/compiler/compilePhases/parser/main/Parser.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.smi \
 smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.smi \
 smlsharp/src/compiler/compilePhases/parser/main/SMLSharpParser.smi \
 smlsharp/src/compiler/compilePhases/parser/main/Parser.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilePhases/parser/main/Parser.o -c \
 smlsharp/src/compiler/compilePhases/parser/main/Parser.sml
CompletionsGenerator.o: CompletionsGenerator.sml \
 smlsharp/src/basis/main/General.smi smlsharp/src/basis/main/StringCvt.smi \
 smlsharp/src/basis/main/IEEEReal.smi smlsharp/src/basis/main/Real64.smi \
 smlsharp/src/basis/main/IntInf.smi smlsharp/src/basis/main/Time.smi \
 smlsharp/src/basis/main/Int8.smi smlsharp/src/basis/main/Int16.smi \
 smlsharp/src/basis/main/Int32.smi \
 smlsharp/src/basis/main/Word8VectorSlice.smi \
 smlsharp/src/basis/main/Word8ArraySlice.smi \
 smlsharp/src/basis/main/Substring.smi smlsharp/src/basis/main/Array.smi \
 smlsharp/src/basis/main/VectorSlice.smi \
 smlsharp/src/basis/main/ArraySlice.smi \
 smlsharp/src/basis/main/Word8Vector.smi smlsharp/src/basis/main/IO.smi \
 smlsharp/src/basis/main/Word8Array.smi \
 smlsharp/src/basis/main/SMLSharp_OSIO.smi \
 smlsharp/src/basis/main/SMLSharp_OSFileSys.smi \
 smlsharp/src/basis/main/SMLSharp_OSProcess.smi \
 smlsharp/src/basis/main/SMLSharp_Runtime.smi \
 smlsharp/src/smlnj/Basis/OS/os-path-fn.smi \
 smlsharp/src/smlnj/Basis/Unix/os-path.smi smlsharp/src/basis/main/OS.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-bin.smi \
 smlsharp/src/smlnj/Basis/IO/bin-io.smi smlsharp/src/basis/main/Bool.smi \
 smlsharp/src/basis/main/Byte.smi smlsharp/src/basis/main/CharArray.smi \
 smlsharp/src/basis/main/CharVectorSlice.smi \
 smlsharp/src/basis/main/CharArraySlice.smi \
 smlsharp/src/basis/main/SMLSharp_ScanChar.smi \
 smlsharp/src/basis/main/Char.smi smlsharp/src/basis/main/CharVector.smi \
 smlsharp/src/basis/main/CommandLine.smi smlsharp/src/smlnj/Basis/date.smi \
 smlsharp/src/basis/main/List.smi smlsharp/src/basis/main/ListPair.smi \
 smlsharp/src/basis/main/Option.smi smlsharp/src/basis/main/Real32.smi \
 smlsharp/src/basis/main/Int64.smi smlsharp/src/basis/main/String.smi \
 smlsharp/src/smlnj/Basis/IO/prim-io-text.smi \
 smlsharp/src/smlnj/Basis/IO/text-io.smi smlsharp/src/basis/main/Text.smi \
 smlsharp/src/basis/main/Timer.smi smlsharp/src/basis/main/Vector.smi \
 smlsharp/src/basis/main/Word8.smi smlsharp/src/basis/main/Word16.smi \
 smlsharp/src/basis/main/Word32.smi smlsharp/src/basis/main/Word64.smi \
 smlsharp/src/basis/main/toplevel.smi smlsharp/src/basis/main/ARRAY.sig \
 smlsharp/src/basis/main/ARRAY_SLICE.sig smlsharp/src/basis/main/STREAM_IO.sig \
 smlsharp/src/basis/main/IMPERATIVE_IO.sig smlsharp/src/basis/main/BIN_IO.sig \
 smlsharp/src/basis/main/BOOL.sig smlsharp/src/basis/main/BYTE.sig \
 smlsharp/src/basis/main/CHAR.sig smlsharp/src/basis/main/COMMAND_LINE.sig \
 smlsharp/src/basis/main/DATE.sig smlsharp/src/basis/main/GENERAL.sig \
 smlsharp/src/basis/main/IEEE_REAL.sig smlsharp/src/basis/main/INTEGER.sig \
 smlsharp/src/basis/main/INT_INF.sig smlsharp/src/basis/main/IO.sig \
 smlsharp/src/basis/main/LIST.sig smlsharp/src/basis/main/LIST_PAIR.sig \
 smlsharp/src/basis/main/MATH.sig smlsharp/src/basis/main/MONO_ARRAY.sig \
 smlsharp/src/basis/main/MONO_ARRAY_SLICE.sig \
 smlsharp/src/basis/main/MONO_VECTOR.sig \
 smlsharp/src/basis/main/MONO_VECTOR_SLICE.sig \
 smlsharp/src/basis/main/OPTION.sig smlsharp/src/basis/main/OS_FILE_SYS.sig \
 smlsharp/src/basis/main/OS_IO.sig smlsharp/src/basis/main/OS_PATH.sig \
 smlsharp/src/basis/main/OS_PROCESS.sig smlsharp/src/basis/main/OS.sig \
 smlsharp/src/basis/main/PRIM_IO.sig smlsharp/src/basis/main/REAL.sig \
 smlsharp/src/basis/main/STRING.sig smlsharp/src/basis/main/STRING_CVT.sig \
 smlsharp/src/basis/main/SUBSTRING.sig \
 smlsharp/src/basis/main/TEXT_STREAM_IO.sig \
 smlsharp/src/basis/main/TEXT_IO.sig smlsharp/src/basis/main/TEXT.sig \
 smlsharp/src/basis/main/TIME.sig smlsharp/src/basis/main/TIMER.sig \
 smlsharp/src/basis/main/VECTOR.sig smlsharp/src/basis/main/VECTOR_SLICE.sig \
 smlsharp/src/basis/main/WORD.sig smlsharp/src/basis.smi \
 smlsharp/src/smlformat/formatlib/main/FormatExpression.smi \
 smlsharp/src/smlformat/formatlib/main/PrinterParameter.smi \
 smlsharp/src/smlformat/formatlib/main/BasicFormatters.smi \
 smlsharp/src/smlformat/formatlib/main/SMLFormat.smi \
 smlsharp/src/smlformat-lib.smi smlsharp/src/smlnj-lib/Util/binary-set-fn.smi \
 smlsharp/src/smlnj-lib/Util2/binary-map-fn2.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/compilePhases/parser/main/SMLSharpParser.smi \
 smlsharp/src/compiler/compilePhases/parser/main/Parser.smi \
 CompletionsGenerator.smi
	$(SMLSHARP) $(SMLFLAGS) -o CompletionsGenerator.o -c \
 CompletionsGenerator.sml
