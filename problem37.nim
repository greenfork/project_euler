#[
The number 3797 has an interesting property. Being prime itself, it is possible
to continuously remove digits from left to right, and remain prime at each stage:
3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to right
and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
]#


from eratosthenes import primesArray

func truncateFromLeftToRight(number: Natural): seq[int] =
  var
    base = 10
    n = number mod base
  while n != number:
    result.add n
    base *= 10
    n = number mod base
  result.add number
assert truncateFromLeftToRight(3797) == @[7, 97, 797, 3797]

func truncateFromRightToLeft(number: Natural): seq[int] =
  var n = number
  while n != 0:
    result.add n
    n = n div 10
assert truncateFromRightToLeft(3797) == @[3797, 379, 37, 3]

var truncatablePrimes: seq[int]

for i in 10..<high(primesArray):
  var truncatablePrime = true
  if primesArray[i] == true:
    for number in truncateFromLeftToRight(i):
      if primesArray[number] == false: truncatablePrime = false
    for number in truncateFromRightToLeft(i):
      if primesArray[number] == false: truncatablePrime = false
    if truncatablePrime: truncatablePrimes.add i

var answer = 0
for i in truncatablePrimes: answer += i
echo answer
