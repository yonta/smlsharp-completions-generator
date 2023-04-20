(**
 * test set for Basis modules which are classified into 'optional'. 
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 * @version $Id: TestMain.sml,v 1.1.28.1 2010/05/11 07:08:04 kiyoshiy Exp $
 *)
structure TestOptionalModules =
struct

  local
    open SMLUnit.Test
  in
  fun tests () =
      [
        TestLabel ("IntInf001", IntInf001.suite ()),
        TestLabel ("IntInf101", IntInf101.suite ()),
        TestLabel ("Array2001", Array2001.suite ()),
        TestLabel ("RealArray001", RealArray001.suite ()),
        TestLabel ("RealArray101", RealArray101.suite ()),
        TestLabel ("RealVector001", RealVector001.suite ()),
        TestLabel ("RealVector101", RealVector101.suite ())
      ]
  end (* local *)

end