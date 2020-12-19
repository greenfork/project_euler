#[
  Prime list up to 1_000_000.
]#

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
