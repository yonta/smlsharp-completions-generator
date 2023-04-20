(**
 * Test case of Word8Vector structure.
 *
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 *)
structure Word8Vector001 = 
ImmutableSequence001(struct
                       open Word8Vector
                       type elem = Word8.word
                       type sequence = vector
                       fun intToElem n = Word8.fromInt n
                       fun nextElem (b : elem) = b + 0w1
                       val elemToString = Word8.toString
                       val compareElem = Word8.compare
                     end)
