fun f 0 x = ()

(*
2011-08-16 katsu

This causes BUG at StaticAnalysis.

[BUG] StaticAnalysis:unification fail(6)
    raised at: ../staticanalysis/main/StaticAnalysis.sml:515.28-515.53
   handled at: ../toplevel2/main/Top.sml:828.37
		main/SimpleMain.sml:269.53

This is due to a RAISE term which has a polymorphic type annotation
which is generated by MatchCompiler.

val f(0) : int(t0) -> ['a. {TAG('a), SIZE('a)} -> 'a -> unit(t7)] =
    fn $T_a(2) : int(t0) =>
       (case $T_a(2) : int(t0) : int(t0) of
          0 =>
          ['a.
           (fn {$4(4) : TAG('a), $5(5) : SIZE('a)} =>
               (fn x(1) : 'a => () : unit(t7)) : 'a -> unit(t7))
           : {TAG('a), SIZE('a)} -> 'a -> unit(t7)]
        | _ =>
          (raise
             cast({1 = EXVAR(Match : boxed(t12))} : {1: int(t0)} : exn(t10)))
          : ['a. 'a -> unit(t7)])   (* <==== type mismatch *)
       : ['a. {TAG('a), SIZE('a)} -> 'a -> unit(t7)]

*)

(*
2011-08-16 katsu

This bug may be fixed by do "compileTy" for the type annotation of RCRAISE
at RecordCompilation.  This fix has been done by changeset 5f44040ba52a.

However, due to this, TLSWITCH with multiple branches may have a polymorphic
type and StaticAnalysis need to unify POLYtys of branches. Is it OK?

*)

(*
2011-08-18 katsu

At today's meeting, we leave this polymorphic type unification as it is
for the time being, and postpone to consider this issue.

*)