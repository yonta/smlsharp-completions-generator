(**
 * Test case of RealVector structure.
 *
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 *)
structure RealVector001 = 
ImmutableSequence001(struct
                       open RealVector
                       type elem = Real.real
                       type sequence = vector
                       fun intToElem n = Real.fromInt n
                       fun nextElem (b : elem) = b + 1.0
                       val elemToString = Real.toString
                       val compareElem = Real.compare
                     end)
