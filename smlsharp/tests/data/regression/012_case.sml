infix 4 ::
val x = case true of true => 1 :: nil | false => nil

(*
2011-08-12 ohori

This causes StaticAnalysis fails.
My preliminary glace suggests that this is due to
the failur of inserting cast in DatatypeConpilation.

2011-08-12 ohori
A temporary fix to DatatypeConpilation by inserting Cast.
Need to be checked.

*)

(*

2011-08-13 katsu

Fixed by changeset 7a4278249f90.

This was due to the lack of correct cast terms which must be
generated by DatatypeCompliation.

*)
