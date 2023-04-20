(**
 * @copyright (C) 2021 SML# Development Team.
 * @author UENO Katsuhiro
 * @author Atsushi Ohori
 *)
structure Symbol =
struct
local
  type loc = Loc.loc
in
  type symbol =
    {string:string, loc:loc}

  fun format_symbol {string, loc} =
      [SMLFormat.FormatExpression.Term (size string, string)]
  fun formatWithLoc_symbol {string, loc} =
      [SMLFormat.FormatExpression.Term (size string, string),
       SMLFormat.FormatExpression.Term (1, "("),
       SMLFormat.FormatExpression.Sequence (Loc.format_loc loc),
       SMLFormat.FormatExpression.Term (1, ")")]

  fun toUserLongSymbols list =
      case list of
        ["Bool","bool"] => ["bool"]
      | ["Int","int"] => ["int"]
      | ["Int8","int"] => ["int8"]
      | ["Int16","int"] => ["int16"]
      | ["Int32","int"] => ["int"]
      | ["Int64","int"] => ["int64"]
      | ["IntInf","int"] => ["intInf"]
      | ["Word","word"] => ["word"]
      | ["Word8","word"] => ["word8"]
      | ["Word16","word"] => ["word16"]
      | ["Word32","word"] => ["word"]
      | ["Word64","word"] => ["word64"]
      | ["Real","real"] => ["real"]
      | ["Real32","real"] => ["real32"]
      | ["Real64","real"] => ["real64"]
      | ["Array","array"] => ["array"]
      | ["Vector","vector"] => ["vector"]
      | "SMLSharp_SQL_Prim"::tl => "SQL"::tl
      | x => x

  type longsymbol =
    symbol list

  fun format_longsymbol symbols =
      SMLFormat.BasicFormatters.format_list
        (format_symbol, [SMLFormat.FormatExpression.Term (1, ".")])
        symbols
  fun formatWithLoc_longsymbol symbols =
      SMLFormat.BasicFormatters.format_list
        (formatWithLoc_symbol, [SMLFormat.FormatExpression.Term (1, ".")])
        symbols

  fun formatWithLoc_longsymbol symbols =
      SMLFormat.BasicFormatters.format_list
        (formatWithLoc_symbol, [SMLFormat.FormatExpression.Term (1, ".")])
        symbols

  fun compare ({string=s1, loc=l1}, {string=s2, loc=l2}) =
      Loc.compareLoc (l1,l2)

  fun lastSymbol longsymbol = List.last longsymbol
  fun symbolToString (s:symbol) = #string s
  fun symbolToLoc (s:symbol) = #loc s
  fun symbolToStringWithLoc (s:symbol) = 
      #string s ^ "(" ^ Loc.locToString (symbolToLoc s) ^ ")"
  fun longsymbolToString (s:longsymbol) = String.concatWith "." (map symbolToString s)
  fun longsymbolToLoc (s:longsymbol) =
      let
        val head = List.hd s
        val (pos1,_) = symbolToLoc head
        val last = List.last s
        val (_, pos2) = symbolToLoc last
      in
        (pos1, pos2)
      end
      handle List.Empty => Loc.noloc
        
  fun longsymbolToLastLoc (s:longsymbol) =
      let
        val last = List.last s
      in
        symbolToLoc last
      end
      handle List.Empty => Loc.noloc
        
  fun longsymbolToLongid (s:longsymbol) = map symbolToString s

  fun coerceLongsymbolToSymbol longsymbol =
      {string = longsymbolToString longsymbol,
       loc = longsymbolToLoc longsymbol}

  fun mkSymbol string loc = {string=string, loc=loc}
  fun mkLongsymbol stringList loc = map (fn s => mkSymbol s loc) stringList

  fun formatUserLongSymbol list =
      format_longsymbol
        (mkLongsymbol (toUserLongSymbols (longsymbolToLongid list)) Loc.noloc)


  fun setVersion (longsymbol, version) =
      longsymbol @ [mkSymbol (Int.toString version) (longsymbolToLoc longsymbol)]
  fun symbolCompare (s1:symbol, s2:symbol) = 
      String.compare(symbolToString s1, symbolToString s2)
  fun longsymbolCompare (s1:longsymbol, s2:longsymbol) = 
      String.compare(longsymbolToString s1, longsymbolToString s2)
  fun eqSymbol (s1:symbol, s2:symbol) = 
      case symbolCompare(s1,s2) of
        EQUAL => true
      | _ => false
  fun eqLongsymbol (s1:longsymbol, s2:longsymbol) = 
      longsymbolToString s1 = longsymbolToString s2

  fun replaceLocSymbol loc {string, loc=_} = {string=string, loc=loc}
  fun replaceLocLongsymbol loc longsymbol = map (replaceLocSymbol loc) longsymbol

  fun prefixPath (path, symbol) =
      let
        val loc = symbolToLoc symbol
        val path = replaceLocLongsymbol loc path
      in
        path@[symbol]
      end
  fun concatPath (path, longsymbol) =
      let
        val loc = longsymbolToLoc longsymbol
        val path = replaceLocLongsymbol loc path
      in
        path @ longsymbol
      end

  val seed = ref nil : char list ref

  fun gensym () =
      let
        fun inc nil = [#"a"]
          | inc (h::t) =
            if h >= #"z"
            then #"a" :: inc t
            else (chr (ord h + 1)) :: t
      in
        seed := inc (!seed);
        implode (rev (!seed))
      end

  (* FIXME: how to ensure the generated symbol is fresh? *)
  fun generate () =
      {string = "$" ^ gensym (), loc = Loc.noloc}

end

end
structure SymbolOrd =
struct
  type ord_key = Symbol.symbol
  val compare = Symbol.symbolCompare
end
structure SymbolEnv = BinaryMapFn2(SymbolOrd)
structure SymbolSet = BinarySetFn(SymbolOrd)

structure LongsymbolOrd = 
struct
  type ord_key = Symbol.symbol list
  fun compare (path1,path2) =
      case (path1, path2) of
        (nil,nil) => EQUAL
      | (nil, _) => LESS
      | (_,nil) =>  GREATER
      | (h1::t1, h2::t2) => 
        (case Symbol.symbolCompare(h1,h2) of
           EQUAL => compare(t1,t2)
         | x => x)
end

structure LongsymbolEnv = BinaryMapFn2(LongsymbolOrd)
structure LongsymbolSet = BinarySetFn(LongsymbolOrd)
