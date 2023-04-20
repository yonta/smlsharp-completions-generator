(**
 * Test case of Word8VectorSlice structure.
 *
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 *)
structure Word8VectorSlice001 = 
ImmutableSequenceSlice001(struct
                            open Word8VectorSlice
                            type elem = Word8.word
                            type sequence = vector
                            type slice = slice
                            type vector = vector
                            fun intToElem n = Word8.fromInt n
                            fun nextElem (b : elem) = b + 0w1
                            val elemToString = Word8.toString
                            val compareElem = Word8.compare
                            val listToSequence = Word8Vector.fromList
                            val sequenceToList =
                                Word8Vector.foldr List.:: ([] : elem list)
                            val vectorToList = sequenceToList
                            val listToVector = listToSequence
                          end)
