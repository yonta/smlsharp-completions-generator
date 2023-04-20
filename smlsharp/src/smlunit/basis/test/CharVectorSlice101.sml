(**
 * Test case of CharVectorSlice structure.
 *
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 *)
structure CharVectorSlice101 = 
SequenceSlice101(struct
                   open CharVectorSlice
                   type elem = char
                   type sequence = vector
                   type slice = slice
                   type vector = vector
                   fun intToElem n = Char.chr (Char.ord #"A" + n)
                   fun nextElem c = Char.chr (Char.ord c + 1)
                   val elemToString = Char.toString
                   val compareElem = Char.compare
                   val listToSequence = CharVector.fromList
                   val sequenceToList =
                       CharVector.foldr List.:: ([] : elem list)
                   val vectorToList = sequenceToList
                   val listToVector = listToSequence
                 end)
