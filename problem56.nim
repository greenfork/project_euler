# Requires bigints library:
# nimble install bigints

import bigints

func pow(a, b: BigInt): BigInt =
  var b = b
  result = 1.initBigInt
  while b > 0:
    result *= a
    b.dec
assert pow(2.initBigInt, 3.initBigInt) == 8
assert pow(3.initBigInt, 4.initBigInt) == 81

func digitSum(a: BigInt): BigInt =
  var a = a
  while a != 0:
    result += a mod 10
    a = a div 10
assert digitSum(1234567.initBigInt) == (1+2+3+4+5+6+7)

var max = 0.initBigInt
for a in 1..<100:
  for b in 1..<100:
    let
      powered = pow(a.initBigInt, b.initBigInt)
      digitSum = digitSum(powered)
    if digitSum > max:
      # echo powered, ": ", digitSum(powered)
      max = digitSum
echo max
