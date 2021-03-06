#[
Pentagonal numbers are generated by the formula, Pn=n(3n−1)/2.
The first ten pentagonal numbers are:

1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...

It can be seen that P4 + P7 = 22 + 70 = 92 = P8. However, their difference,
70 − 22 = 48, is not pentagonal.

Find the pair of pentagonal numbers, Pj and Pk, for which their sum and
difference are pentagonal and D = |Pk − Pj| is minimised; what is the value of D?
]#

from perfect_square import findPerfectSquareRoot

iterator pentagonalNumbers(): uint =
  var n: uint = 1
  while true:
    yield n * (3 * n - 1) div 2
    n.inc

const arrayLength = 1_000_0

var pentagonalNumbersArray {.noinit.}: array[arrayLength, uint]
block:
  var cnt = 0
  for n in pentagonalNumbers():
    if cnt == pentagonalNumbersArray.len: break
    pentagonalNumbersArray[cnt] = n
    cnt.inc

# var differences {.noinit.}: array[arrayLength - 1, uint]
# block:
#   for i in 0..<differences.len:
#     differences[i] = pentagonalNumbersArray[i+1] - pentagonalNumbersArray[i]

func isPentagonalNumber(n: uint): bool =
  findPerfectSquareRoot(24*n + 1) mod 6 == 5
assert isPentagonalNumber(1080)
assert isPentagonalNumber(1520)
assert not isPentagonalNumber(3)

# for i in 0..<differences.len:
#   let
#     a = pentagonalNumbersArray[i]
#     b = pentagonalNumbersArray[i+1]
#   if isPentagonalNumber(differences[i]):
#     echo a, ", ", b, ", sum: ", a + b, ", difference: ", differences[i]
#     if isPentagonalNumber(a + b):
#       echo "found: ", a, ", ", b, ", sum: ", a + b, ", difference: ", differences[i]

for i in 0..<(pentagonalNumbersArray.len - 1):
  for k in (i + 1)..<pentagonalNumbersArray.len:
    let
      a = pentagonalNumbersArray[i]
      b = pentagonalNumbersArray[k]
    if isPentagonalNumber(b - a) and isPentagonalNumber(a + b):
      echo a, ", ", b, ", sum: ", a + b, ", difference: ", b - a
