(**
 * Test case of CharArray structure.
 *
 * @author YAMATODANI Kiyoshi
 * @copyright (C) 2021 SML# Development Team.
 *)
structure CharArray101 = 
Sequence101(struct
              open CharArray
              type elem = Char.char
              type sequence = array
              fun intToElem n = Char.chr (Char.ord #"A" + n);
              fun nextElem c = Char.chr (Char.ord c + 1)
              val elemToString = Char.toString
              val compareElem = Char.compare
            end)
