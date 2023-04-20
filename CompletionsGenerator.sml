val filename = "./test-input.smi"
val instream = TextIO.openIn filename
fun read n = TextIO.inputN (instream, n)
val locSource = Loc.FILE (Loc.USERPATH, Filename.fromString filename)
val source = { read = read, source = locSource }
val input = InterfaceParser.setup source
val itop = InterfaceParser.parse input

(* test print *)
val exps = AbsynInterface.format_itop itop
val format = SMLFormat.prettyPrint nil exps
val () = print format
