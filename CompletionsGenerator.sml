(* main *)
val filename = "./test-input.sml"
val file = Filename.fromString filename
val instream = TextIO.openIn filename
fun read (isFirst, n) = TextIO.inputN (instream, n)
val locSource = Loc.FILE (Loc.USERPATH, file)
val source = { source = locSource, read = read, initialLineno = 0 }
val input = Parser.setup source
val absyn = case Parser.parse input of
                Absyn.UNIT unit => unit
              (* | Absyn.EOF => raise Fail "empty" *)
              | Absyn.EOF => { interface = Absyn.NOINTERFACE,
                               tops = nil,
                               loc = Loc.noloc }
val systemBaseDir = "/usr/lib/x86_64-linux-gnu/smlsharp"
val options = { baseFilename = NONE,
                loadPath = [(Loc.STDPATH, SystemBaseDir)],
                loadMode = InterfaceName.COMPILE,
                defaultInterface = fn x => x }
val (dependency, prelude, interfaceUnit) = LoadFile.load options absyn
