(**
 * Collection of modules.
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 * @version $Id: SMLUNIT.sig,v 1.2 2004/10/20 02:09:35 kiyoshiy Exp $
 *)
signature SMLUNIT =
sig

  (***************************************************************************)

  structure Assert : ASSERT

  structure Test : TEST

  structure TextUITestRunner : TESTRUNNER

(*
  structure HTMLReportTestRunner : TESTRUNNER
*)

  (***************************************************************************)

end