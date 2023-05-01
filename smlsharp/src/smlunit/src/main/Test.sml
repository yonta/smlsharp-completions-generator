(**
 * datatypes for test cases and utility operators for them.
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 * @version $Id: Test.sml,v 1.2 2004/10/20 02:09:35 kiyoshiy Exp $
 *)
structure Test :> TEST =
struct
  
  (***************************************************************************)

  type testFunction = unit -> unit

  datatype test =
           TestCase of (unit -> unit)
         | Test of string * (unit -> unit)
         | TestLabel of (string * test)
         | TestList of test list

  (***************************************************************************)

  fun labelTests labelTestPairList =
      TestList
      (map
       (fn (label, function) => (TestLabel (label, TestCase function)))
       labelTestPairList)

  (***************************************************************************)

end
