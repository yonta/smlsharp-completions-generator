(**
 * common functions which array_slices and vector_slices provide.
 *
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 *)
signature SEQUENCE_SLICE =
sig

  type elem
  type slice
  type sequence
  type vector

  val length : slice -> int
  val sub : slice * int -> elem
  val full : sequence -> slice
  val slice : sequence * int * int option -> slice
  val subslice : slice * int * int option -> slice
  val base : slice -> sequence * int * int
  val vector : slice -> vector
  val isEmpty : slice -> bool
  val getItem : slice -> (elem * slice) option
  val appi : (int * elem -> unit) -> slice -> unit
  val app  : (elem -> unit) -> slice -> unit
  val foldli : (int * elem * 'b -> 'b) -> 'b -> slice -> 'b
  val foldri : (int * elem * 'b -> 'b) -> 'b -> slice -> 'b
  val foldl  : (elem * 'b -> 'b) -> 'b -> slice -> 'b
  val foldr  : (elem * 'b -> 'b) -> 'b -> slice -> 'b
  val findi : (int * elem -> bool) -> slice -> (int * elem) option
  val find  : (elem -> bool) -> slice -> elem option
  val exists : (elem -> bool) -> slice -> bool
  val all : (elem -> bool) -> slice -> bool
  val collate : (elem * elem -> order) -> slice * slice -> order 

  (* following functions are used to write test code. *)
                                                                 
  val intToElem : int -> elem
  val nextElem : elem -> elem
  val elemToString : elem -> string
  val compareElem : (elem * elem) -> General.order
  val listToSequence : elem list -> sequence
  val sequenceToList : sequence -> elem list
  val vectorToList : vector -> elem list
  val listToVector : elem list -> vector

end
