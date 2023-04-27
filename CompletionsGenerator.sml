(* main *)
val filename = "./test-input.sml"
val file = Filename.fromString filename
val instream = TextIO.openIn filename
fun read (isFirst, n) = TextIO.inputN (instream, n)
val locSource = Loc.FILE (Loc.USERPATH, file)
val source = { source = locSource, read = read, initialLineno = 0 }
val input = Parser.setup source
val parsed = case Parser.parse input of
                 Absyn.UNIT unit => unit
               | Absyn.EOF => raise Fail "empty"
val { interface, tops, loc } = parsed
