(**
 * Test case of Vector structure.
 *
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 *)
structure Vector001 =
ImmutableSequence001(struct
                       open Vector
                       type elem = int
                       type sequence = int vector
                       type vector = int vector
                       fun intToElem n = n
                       fun nextElem n = n + 1
                       val elemToString = Int.toString
                       val compareElem = Int.compare
                     end)