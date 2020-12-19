#[
We shall say that an n-digit number is pandigital if it makes use of all the
digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is
also prime.

What is the largest n-digit pandigital prime that exists?
]#

from strutils import parseInt
from eratosthenes import isPrime

iterator HeapsPermutations(n: int, s: string): string =
  var
    stack: seq[int]
    stackPointer = 0
    s = s
  for i in 0..<n: stack.add 0
  yield s
  while stackPointer < n:
    if stack[stackPointer] < stackPointer:
      if stackPointer mod 2 == 0:
        swap(s[0], s[stackPointer])
      else:
        swap(s[stack[stackPointer]], s[stackPointer])
      yield s
      stack[stackPointer] += 1
      stackPointer = 0
    else:
      stack[stackPointer] = 0
      stackPointer += 1

iterator pandigitalPermutations(numberOfDigits: Natural): int =
  assert numberOfDigits < 10
  var s: string
  for i in 1..numberOfDigits:
    s.add $i
  for p in HeapsPermutations(numberOfDigits, s):
    yield parseInt(p)

var largestPrimePandigital = 0
for i in 1..9:
  for perm in pandigitalPermutations(i):
    if perm > largestPrimePandigital and isPrime(perm):
      largestPrimePandigital = perm
echo largestPrimePandigital
