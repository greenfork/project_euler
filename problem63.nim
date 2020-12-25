import bigints

func pow(a: int, b: Positive): BigInt =
  var b = b.int
  let a = a.initBigInt
  result = 1.initBigInt
  while b != 0:
    result *= a
    b.dec
assert pow(3, 4) == 81.initBigInt

func digitLen(a: BigInt): Positive =
  var a = a
  result = 1
  while a != 0:
    result.inc
    a = a div 10
  result.dec
assert digitLen(12345.initBigInt) == 5
assert digitLen(12.initBigInt) == 2

var cnt = 0
for power in 1..100:
  for n in 1..10000:
    let
      n = n.initBigInt
      power = power.int32
      powered = pow(n, power)
      length = digitLen(powered)
    if length == power:
      cnt.inc
      echo "n: ", n, ", power: ", power, ", length: ", length,
           ", powered: ", powered
    elif length > power:
      break

echo cnt
