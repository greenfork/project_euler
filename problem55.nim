# Requires bigints library:
# nimble install bigints

from algorithm import reverse
from strutils import parseInt
import bigints

func isPalindrome(s: string): bool =
  var
    i = 0
    k = s.len - 1
  result = true
  while i < k:
    if s[i] != s[k]:
      result = false
      break
    i.inc
    k.dec
assert isPalindrome("123321")
assert isPalindrome("123454321")

func LychrelIteration(n: BigInt): BigInt =
  var s = $n
  s.reverse
  # debugecho "n: ", n, ", s: ", s
  initBigInt(s) + n
assert LychrelIteration(47.initBigInt) == 121
assert LychrelIteration(349.initBigInt) == 1292
assert LychrelIteration(1292.initBigInt) == 4213
assert LychrelIteration(4213.initBigInt) == 7337

func isLychrelNumber(n: BigInt): bool =
  const iterationLimit = 50
  result = true
  var n = n
  for i in 0..<iterationLimit:
    # debugecho "iteration no ", i
    n = LychrelIteration(n)
    if isPalindrome($n):
      result = false
      break
assert not isLychrelNumber(349.initBigInt)
assert not isLychrelNumber(47.initBigInt)
assert isLychrelNumber(196.initBigInt)
assert isLychrelNumber(10677.initBigInt)
assert isLychrelNumber(4994.initBigInt)

var cnt = 0
for n in 1..<10_000:
  if isLychrelNumber(n.initBigInt): cnt.inc
echo cnt
