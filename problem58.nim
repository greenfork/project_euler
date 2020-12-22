# 65 64 63 62 61 60 59 58 57
# 66 37 36 35 34 33 32 31 56
# 67 38 17 16 15 14 13 30 55
# 68 39 18  5  4  3 12 29 54
# 69 40 19  6  1  2 11 28 53
# 70 41 20  7  8  9 10 27 52
# 71 42 21 22 23 24 25 26 51
# 72 43 44 45 46 47 48 49 50
# 73 74 75 76 77 78 79 80 81

# UR: 3 13 31 57, diff: 10, 18, 26
# UL: 5 17 37 65, diff: 12, 20, 28
# BL: 7 21 43 73, diff: 14, 22, 30

from eratosthenes import isPrime

var
  primesCount = 0
  notPrimesCount = 1 # intiail `1` is counted
  increment = 0
let
  ur1 = 3
  ul1 = 5
  bl1 = 7
  urFirstDiff = 10
  ulFirstDiff = 12
  blFirstDiff = 14

for i in 0..<1000_000:
  notPrimesCount.inc # bottom right diagonal
  if i > 1:
    increment += (i - 1) * 8
  let
    ur = ur1 + i * urFirstDiff + increment
    ul = ul1 + i * ulFirstDiff + increment
    bl = bl1 + i * blFirstDiff + increment
  if isPrime ur:
    primesCount.inc
  else:
    notPrimesCount.inc
  if isPrime ul:
    primesCount.inc
  else:
    notPrimesCount.inc
  if isPrime bl:
    primesCount.inc
  else:
    notPrimesCount.inc
  let ratio = primesCount.float/(notPrimesCount + primesCount).float
  echo "ratio: ", ratio,
       ", primes: ", primesCount, ", total: ", notPrimesCount+primesCount,
       ", iteration: ", i, ", side length: ", i*2+3
  if ratio < 0.1: break
