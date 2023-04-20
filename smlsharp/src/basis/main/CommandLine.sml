(**
 * CommandLine
 * @author UENO Katsuhiro
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 *)

infix 6 + - ^
infixr 5 ::
infix 4 = <> > >= < <=
val op - = SMLSharp_Builtin.Int32.sub_unsafe
val op > = SMLSharp_Builtin.Int32.gt
structure Pointer = SMLSharp_Builtin.Pointer

structure CommandLine =
struct

  val prim_argc =
      _import "prim_CommandLine_argc"
      : __attribute__((fast)) () -> int
  val prim_argv =
      _import "prim_CommandLine_argv"
      : __attribute__((fast)) () -> char ptr ptr
  val sml_str_new =
      _import "sml_str_new"
      : __attribute__((unsafe,fast,gc)) char ptr -> string

  fun name () =
      let
        val argc = prim_argc ()
        val argv = prim_argv ()
      in
        if argc > 0
        then sml_str_new (Pointer.deref argv)
        else ""
      end

  fun arguments () =
      let
        val argc = prim_argc ()
        val argv = prim_argv ()
        fun loop (i, l) =
            if i > 1
            then let val p = Pointer.advance (argv, i - 1)
                     val s = sml_str_new (Pointer.deref p)
                 in loop (i - 1, s :: l)
                 end
            else l
      in
        loop (argc, nil)
      end

end
