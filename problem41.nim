#[
We shall say that an n-digit number is pandigital if it makes use of all the
digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is
also prime.

What is the largest n-digit pandigital prime that exists?
]#

from strutils import parseInt
from eratosthenes import isPrime
from heaps_permutations import HeapsPermutations

iterator pandigitalPermutations(numberOfDigits: Natural): int =
  assert numberOfDigits < 10
  var s: string
  for i in 1..numberOfDigits:
    s.add $i
  for p in HeapsPermutations(s):
    yield parseInt(p)

var largestPrimePandigital = 0
for i in 1..9:
  for perm in pandigitalPermutations(i):
    if perm > largestPrimePandigital and isPrime(perm):
      largestPrimePandigital = perm
echo largestPrimePandigital
