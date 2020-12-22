from sequtils import mapIt
from strutils import split, parseInt, join, find
from math import sum

const file = readFile("problem59.txt")
let initialText = file.split(',').mapIt(it.parseInt)

func translateFromIntegers(text: seq[int]): string =
  text.mapIt(it.chr).join

func xorSeq(ss: seq[int], key: seq[int]): seq[int] =
  for i in 0..<ss.len:
    result.add(ss[i] xor key[i])

const lowerLetters = {'a'..'z'}

for a in lowerLetters:
  for b in lowerLetters:
    for c in lowerLetters:
      var key: seq[int]
      while key.len < initialText.len:
        key &= @[a.ord, b.ord, c.ord]
      key.setLen(initialText.len)
      let
        decrypted = xorSeq(initialText, key)
        text = translateFromIntegers(decrypted)
      if text.find(" the ") != -1:
        echo text
        echo sum(decrypted)
