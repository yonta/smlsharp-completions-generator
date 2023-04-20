SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
SMLFORMAT = smlformat
SMLLEX = smllex
SMLYACC = smlyacc
all: CompletionsGenerator
CompletionsGenerator: smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi \
 smlsharp/src/compiler/libs/env/main/SSet.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/extensions/usererror/main/USER_ERROR.sig \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.smi \
 smlsharp/src/compiler/data/control/main/PrintControl.smi \
 smlsharp/src/compiler/data/control/main/Control.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/libs/env/main/IOrd.smi \
 smlsharp/src/compiler/libs/env/main/IEnv.smi \
 smlsharp/src/compiler/libs/env/main/ISet.smi \
 smlsharp/src/compiler/libs/ids/main/GenIDFun.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi \
 smlsharp/src/compiler/libs/list-utils/main/ListSorter.smi \
 smlsharp/src/compiler/libs/util/main/TermFormat.smi \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/ConstFormat.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.smi \
 smlsharp/src/compiler/libs/digest/main/SHA3.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.smi \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.smi \
 smlsharp/src/compiler/compilePhases/parser/main/interface.lex.smi \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.smi \
 smlsharp/src/compiler/compilePhases/parser/main/InterfaceParser.smi \
 CompletionsGenerator.smi smlsharp/src/compiler/libs/env/main/SOrd.o \
 smlsharp/src/compiler/libs/env/main/SEnv.o \
 smlsharp/src/compiler/libs/env/main/SSet.o \
 smlsharp/src/compiler/libs/toolchain/main/Filename.o \
 smlsharp/src/compiler/data/symbols/main/Loc.o \
 smlsharp/src/compiler/extensions/debug/main/Bug.o \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.o \
 smlsharp/src/compiler/data/control/main/PrintControl.o \
 smlsharp/src/compiler/data/control/main/Control.o \
 smlsharp/src/compiler/data/symbols/main/Symbol.o \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.o \
 smlsharp/src/compiler/libs/env/main/IOrd.o \
 smlsharp/src/compiler/libs/env/main/IEnv.o \
 smlsharp/src/compiler/libs/env/main/ISet.o \
 smlsharp/src/compiler/libs/ids/main/GenIDFun.o \
 smlsharp/src/compiler/libs/ids/main/LocalID.o \
 smlsharp/src/compiler/libs/list-utils/main/ListSorter.o \
 smlsharp/src/compiler/libs/util/main/TermFormat.o \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/ConstFormat.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.o \
 smlsharp/src/compiler/libs/digest/main/SHA3.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.o \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.o \
 smlsharp/src/compiler/compilePhases/parser/main/interface.lex.o \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.o \
 smlsharp/src/compiler/compilePhases/parser/main/InterfaceParser.o \
 CompletionsGenerator.o
	$(SMLSHARP) $(LDFLAGS) -o CompletionsGenerator \
 CompletionsGenerator.smi $(LIBS)
smlsharp/src/compiler/libs/env/main/SOrd.o: \
 smlsharp/src/compiler/libs/env/main/SOrd.sml \
 smlsharp/src/compiler/libs/env/main/SOrd.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/compiler/libs/env/main/SOrd.o \
 -c smlsharp/src/compiler/libs/env/main/SOrd.sml
smlsharp/src/compiler/libs/env/main/SEnv.o: \
 smlsharp/src/compiler/libs/env/main/SEnv.sml \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/compiler/libs/env/main/SEnv.o \
 -c smlsharp/src/compiler/libs/env/main/SEnv.sml
smlsharp/src/compiler/libs/env/main/SSet.o: \
 smlsharp/src/compiler/libs/env/main/SSet.sml \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SSet.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/compiler/libs/env/main/SSet.o \
 -c smlsharp/src/compiler/libs/env/main/SSet.sml
smlsharp/src/compiler/libs/toolchain/main/Filename.o: \
 smlsharp/src/compiler/libs/toolchain/main/Filename.sml \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi \
 smlsharp/src/compiler/libs/env/main/SSet.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/libs/toolchain/main/Filename.o -c \
 smlsharp/src/compiler/libs/toolchain/main/Filename.sml
smlsharp/src/compiler/data/symbols/main/Loc.o: \
 smlsharp/src/compiler/data/symbols/main/Loc.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/data/symbols/main/Loc.o -c \
 smlsharp/src/compiler/data/symbols/main/Loc.sml
smlsharp/src/compiler/extensions/debug/main/Bug.o: \
 smlsharp/src/compiler/extensions/debug/main/Bug.sml \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/extensions/debug/main/Bug.o -c \
 smlsharp/src/compiler/extensions/debug/main/Bug.sml
smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.o: \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/extensions/usererror/main/USER_ERROR.sig \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.o -c \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.sml
smlsharp/src/compiler/data/control/main/PrintControl.o: \
 smlsharp/src/compiler/data/control/main/PrintControl.sml \
 smlsharp/src/compiler/data/control/main/PrintControl.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/data/control/main/PrintControl.o -c \
 smlsharp/src/compiler/data/control/main/PrintControl.sml
smlsharp/src/compiler/data/control/main/Control.o: \
 smlsharp/src/compiler/data/control/main/Control.sml \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/data/control/main/PrintControl.smi \
 smlsharp/src/compiler/data/control/main/Control.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/data/control/main/Control.o -c \
 smlsharp/src/compiler/data/control/main/Control.sml
smlsharp/src/compiler/data/symbols/main/Symbol.o: \
 smlsharp/src/compiler/data/symbols/main/Symbol.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/data/symbols/main/Symbol.o -c \
 smlsharp/src/compiler/data/symbols/main/Symbol.sml
smlsharp/src/compiler/data/symbols/main/RecordLabel.o: \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.o -c \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.sml
smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.sml \
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
smlsharp/src/compiler/libs/env/main/IOrd.o: \
 smlsharp/src/compiler/libs/env/main/IOrd.sml \
 smlsharp/src/compiler/libs/env/main/IOrd.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/compiler/libs/env/main/IOrd.o \
 -c smlsharp/src/compiler/libs/env/main/IOrd.sml
smlsharp/src/compiler/libs/env/main/IEnv.o: \
 smlsharp/src/compiler/libs/env/main/IEnv.sml \
 smlsharp/src/compiler/libs/env/main/IOrd.smi \
 smlsharp/src/compiler/libs/env/main/IEnv.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/compiler/libs/env/main/IEnv.o \
 -c smlsharp/src/compiler/libs/env/main/IEnv.sml
smlsharp/src/compiler/libs/env/main/ISet.o: \
 smlsharp/src/compiler/libs/env/main/ISet.sml \
 smlsharp/src/compiler/libs/env/main/IOrd.smi \
 smlsharp/src/compiler/libs/env/main/ISet.smi
	$(SMLSHARP) $(SMLFLAGS) -o smlsharp/src/compiler/libs/env/main/ISet.o \
 -c smlsharp/src/compiler/libs/env/main/ISet.sml
smlsharp/src/compiler/libs/ids/main/GenIDFun.o: \
 smlsharp/src/compiler/libs/ids/main/GenIDFun.sml \
 smlsharp/src/compiler/libs/env/main/IOrd.smi \
 smlsharp/src/compiler/libs/env/main/IEnv.smi \
 smlsharp/src/compiler/libs/env/main/ISet.smi \
 smlsharp/src/compiler/libs/ids/main/GenIDFun.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/libs/ids/main/GenIDFun.o -c \
 smlsharp/src/compiler/libs/ids/main/GenIDFun.sml
smlsharp/src/compiler/libs/ids/main/LocalID.o: \
 smlsharp/src/compiler/libs/ids/main/LocalID.sml \
 smlsharp/src/compiler/libs/ids/main/GenIDFun.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/libs/ids/main/LocalID.o -c \
 smlsharp/src/compiler/libs/ids/main/LocalID.sml
smlsharp/src/compiler/libs/list-utils/main/ListSorter.o: \
 smlsharp/src/compiler/libs/list-utils/main/ListSorter.sml \
 smlsharp/src/compiler/libs/list-utils/main/ListSorter.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/libs/list-utils/main/ListSorter.o -c \
 smlsharp/src/compiler/libs/list-utils/main/ListSorter.sml
smlsharp/src/compiler/libs/util/main/TermFormat.o: \
 smlsharp/src/compiler/libs/util/main/TermFormat.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi \
 smlsharp/src/compiler/libs/list-utils/main/ListSorter.smi \
 smlsharp/src/compiler/libs/util/main/TermFormat.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/libs/util/main/TermFormat.o -c \
 smlsharp/src/compiler/libs/util/main/TermFormat.sml
smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.o: \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/libs/list-utils/main/ListSorter.smi \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.o -c \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi \
 smlsharp/src/compiler/libs/util/main/TermFormat.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.sml
smlsharp/src/compiler/compilerIRs/absyn/main/ConstFormat.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/ConstFormat.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/ConstFormat.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/ConstFormat.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/ConstFormat.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/ConstFormat.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi \
 smlsharp/src/compiler/libs/util/main/TermFormat.smi \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi \
 smlsharp/src/compiler/libs/util/main/TermFormat.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.sml
smlsharp/src/compiler/libs/digest/main/SHA3.o: \
 smlsharp/src/compiler/libs/digest/main/SHA3.sml \
 smlsharp/src/compiler/libs/digest/main/SHA3.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/libs/digest/main/SHA3.o -c \
 smlsharp/src/compiler/libs/digest/main/SHA3.sml
smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.sml \
 smlsharp/src/compiler/libs/digest/main/SHA3.smi \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.sml
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.o: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi \
 smlsharp/src/compiler/libs/env/main/SOrd.smi \
 smlsharp/src/compiler/libs/env/main/SEnv.smi \
 smlsharp/src/compiler/libs/util/main/TermFormat.smi \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.o -c \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.sml
smlsharp/src/compiler/compilePhases/parser/main/interface.grm.o: \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.smi \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.o -c \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.sml
smlsharp/src/compiler/compilePhases/parser/main/interface.lex.o: \
 smlsharp/src/compiler/compilePhases/parser/main/interface.lex.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.smi \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.smi \
 smlsharp/src/compiler/compilePhases/parser/main/interface.lex.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilePhases/parser/main/interface.lex.o -c \
 smlsharp/src/compiler/compilePhases/parser/main/interface.lex.sml
smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.o: \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.sml \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.o -c \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.sml
smlsharp/src/compiler/compilePhases/parser/main/InterfaceParser.o: \
 smlsharp/src/compiler/compilePhases/parser/main/InterfaceParser.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.smi \
 smlsharp/src/compiler/data/control/main/PrintControl.smi \
 smlsharp/src/compiler/data/control/main/Control.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.smi \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.smi \
 smlsharp/src/compiler/compilePhases/parser/main/interface.lex.smi \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.smi \
 smlsharp/src/compiler/compilePhases/parser/main/InterfaceParser.smi
	$(SMLSHARP) $(SMLFLAGS) -o \
 smlsharp/src/compiler/compilePhases/parser/main/InterfaceParser.o -c \
 smlsharp/src/compiler/compilePhases/parser/main/InterfaceParser.sml
CompletionsGenerator.o: CompletionsGenerator.sml \
 smlsharp/src/compiler/libs/toolchain/main/Filename.smi \
 smlsharp/src/compiler/data/symbols/main/Loc.smi \
 smlsharp/src/compiler/data/symbols/main/Symbol.smi \
 smlsharp/src/compiler/libs/ids/main/LocalID.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.smi \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.smi \
 smlsharp/src/compiler/extensions/debug/main/Bug.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.smi \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.smi \
 smlsharp/src/compiler/compilePhases/parser/main/InterfaceParser.smi \
 CompletionsGenerator.smi
	$(SMLSHARP) $(SMLFLAGS) -o CompletionsGenerator.o -c \
 CompletionsGenerator.sml
smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.sml: \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg
	$(SMLFORMAT) --output=$@ $<
smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.sml: \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg
	$(SMLFORMAT) --output=$@ $<
smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.sml: \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg
	$(SMLFORMAT) --output=$@ $<
smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.sml: \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg
	$(SMLFORMAT) --output=$@ $<
smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.sml: \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg
	$(SMLFORMAT) --output=$@ $<
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
smlsharp/src/compiler/compilePhases/parser/main/interface.grm.sml: \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm
	$(SMLYACC) -s -p $< $<
smlsharp/src/compiler/compilePhases/parser/main/interface.lex.sml: \
 smlsharp/src/compiler/compilePhases/parser/main/interface.lex
	$(SMLLEX) -o $@ $<

clean:
	rm -f CompletionsGenerator CompletionsGenerator.o \
 smlsharp/src/compiler/compilePhases/parser/main/InterfaceParser.o \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.o \
 smlsharp/src/compiler/compilePhases/parser/main/ParserError.ppg.sml \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.desc \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.o \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.sml \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.sml.desc \
 smlsharp/src/compiler/compilePhases/parser/main/interface.grm.sml.sml \
 smlsharp/src/compiler/compilePhases/parser/main/interface.lex.o \
 smlsharp/src/compiler/compilePhases/parser/main/interface.lex.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/Absyn.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConst.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynConstFormatter.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynFormatter.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynInterface.ppg.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQL.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynSQLFormatter.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTy.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/AbsynTyFormatter.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/ConstFormat.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.o \
 smlsharp/src/compiler/compilerIRs/absyn/main/InterfaceName.ppg.sml \
 smlsharp/src/compiler/compilerIRs/absyn/main/RequirePath.o \
 smlsharp/src/compiler/data/control/main/Control.o \
 smlsharp/src/compiler/data/control/main/PrintControl.o \
 smlsharp/src/compiler/data/symbols/main/Loc.o \
 smlsharp/src/compiler/data/symbols/main/RecordLabel.o \
 smlsharp/src/compiler/data/symbols/main/Symbol.o \
 smlsharp/src/compiler/extensions/debug/main/Bug.o \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.o \
 smlsharp/src/compiler/extensions/format-utils/main/SmlppgUtil.ppg.sml \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.o \
 smlsharp/src/compiler/extensions/usererror/main/UserError.ppg.sml \
 smlsharp/src/compiler/libs/digest/main/SHA3.o \
 smlsharp/src/compiler/libs/env/main/IEnv.o \
 smlsharp/src/compiler/libs/env/main/IOrd.o \
 smlsharp/src/compiler/libs/env/main/ISet.o \
 smlsharp/src/compiler/libs/env/main/SEnv.o \
 smlsharp/src/compiler/libs/env/main/SOrd.o \
 smlsharp/src/compiler/libs/env/main/SSet.o \
 smlsharp/src/compiler/libs/ids/main/GenIDFun.o \
 smlsharp/src/compiler/libs/ids/main/LocalID.o \
 smlsharp/src/compiler/libs/list-utils/main/ListSorter.o \
 smlsharp/src/compiler/libs/toolchain/main/Filename.o \
 smlsharp/src/compiler/libs/util/main/TermFormat.o
