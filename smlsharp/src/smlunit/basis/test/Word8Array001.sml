(**
 * Test case of Word8Array structure.
 *
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 *)
structure Word8Array001 = 
MutableSequence001(struct
                     open Word8Array
                     type elem = Word8.word
                     type sequence = array
                     fun intToElem n = Word8.fromInt n
                     fun nextElem (b : elem) = b + 0w1
                     val elemToString = Word8.toString
                     val compareElem = Word8.compare
                     val listToVector = Word8Vector.fromList
                     val vectorToList = Word8Vector.foldr List.:: []
                   end)
