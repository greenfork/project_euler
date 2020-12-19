#[
  Prime list up to 1_000_000.
]#

from math import sqrt

const
  highLimitSqrt = 1000
  highLimit = highLimitSqrt * highLimitSqrt
var primesArray* {.noInit.}: array[highLimit, bool]
primesArray[0] = false
primesArray[1] = false
for i in 2..<highLimit: primesArray[i] = true

for i in 2..highLimitSqrt:
  if primesArray[i] == true:
    for k in countup(i*i, highLimit - 1, i):
      primesArray[k] = false

# Print all primes.

# for i in 0..<highLimit:
#   if primesArray[i] == true:
#     echo i

proc isPrime*(n: int): bool =
  let limit = sqrt(n.float).int
  assert limit < highLimit # else our prime array is not big enough
  result = true
  for i in 0..limit:
    if primesArray[i] == true and n mod i == 0:
      return false
