fun parse filename =
    let
      val instream = TextIO.openIn filename
      fun read n = TextIO.inputN (instream, n)
      val locSource = Loc.FILE (Loc.USERPATH, Filename.fromString filename)
      val source = { read = read, source = locSource }
      val input = InterfaceParser.setup source
    in
      InterfaceParser.parse input
    end

local
open AbsynInterface
in
  fun idecToString idec =
      case idec of
          IVAL valbind => ""
        | ITYPE typebinds => ""
        | IDATATYPE {datbind, withType, loc} => ""
        | ITYPEREP {symbol, longsymbol, loc} => ""
        | ITYPEBUILTIN {symbol, builtinSymbol, loc} => ""
        | IEXCEPTION exbinds => ""
        | ISTRUCTURE {symbol, strexp, loc} => ""


  fun itopdecToString itopdec =
      case itopdec of
          IDEC idec => idecToString idec
        | IFUNDEC funbind => ""   (* functor *)
        | IINFIX {fixity, symbols, loc} => "" (* infix *)

  fun itopToString itop =
      case itop of
          INTERFACE { requires, provide = itopdecs } =>
          map itopdecToString itopdecs
        | INCLUDES { includes, topdecs } =>
          nil
end

(* test print *)
val filename = "./test-input.smi"
val itop = parse filename
val exps = AbsynInterface.format_itop itop
val format = SMLFormat.prettyPrint nil exps
val () = print format
