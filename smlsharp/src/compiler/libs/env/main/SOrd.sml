(**
 * @copyright (C) 2021 SML# Development Team.
 * @author Atsushi Ohori
 * @version $Id: SOrd.sml,v 1.1 2007/09/07 14:19:47 kiyoshiy Exp $
 *)
structure SOrd =
struct 
  type ord_key = string
  val compare = String.compare
end
