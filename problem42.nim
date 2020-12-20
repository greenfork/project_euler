#[
The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1);
so the first ten triangle numbers are:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its alphabetical
position and adding these values we form a word value. For example, the word value
for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number then
we shall call the word a triangle word.

Using problem42.txt (right click and 'Save Link/Target As...'), a 16K text file
containing nearly two-thousand common English words, how many are triangle words?
]#

from strutils import split
from sequtils import mapIt

const
  file = slurp("problem42.txt")
let
  words = file.split(',').mapIt(it[1..^2])

iterator triangleNumbers(): int =
  var n = 1
  while true:
    yield n * (n + 1) div 2
    n.inc

func wordValue(word: string): int =
  const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  for ch in word:
    result += alphabet.find(ch) + 1

var triangleWordsCount = 0
for word in words:
  let value = wordValue(word)
  for triangleNumber in triangleNumbers():
    if triangleNumber > value:
      break
    elif triangleNumber == value:
      triangleWordsCount.inc
      break

echo triangleWordsCount
