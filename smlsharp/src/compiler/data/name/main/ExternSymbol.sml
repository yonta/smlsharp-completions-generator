(**
 * external symbols
 *
 * @copyright (C) 2021 SML# Development Team.
 * @author UENO Katsuhiro
 *)

signature EXTERN_SYMBOL =
sig
  type id
  val touch : Symbol.longsymbol -> id
  val toString : id -> string
  val format_id : id -> SMLFormat.FormatExpression.expression list
  structure Map : ORD_MAP where type Key.ord_key = id
  structure Set : ORD_SET where type item = id
end

structure ExternSymbol :> EXTERN_SYMBOL =
struct

  type id = string

  fun touch path =
      NameMangle.mangle (Symbol.longsymbolToLongid path)

  fun toString x = x : id

  fun format_id id =
      let
        val s = toString id
      in
        [SMLFormat.FormatExpression.Term (size s, s)]
      end

  structure Map = SEnv
  structure Set = SSet

end

structure ExternFunSymbol :> EXTERN_SYMBOL = ExternSymbol
