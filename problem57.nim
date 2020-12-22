import bigints

# Standard rational can't take BigInt as its numerator and denominator.
type
  MyRational = object
    num, den: BigInt

func `$`(r: MyRational): string = $r.num & "/" & $r.den

func cmpDigitLen(a, b: BigInt): BigInt =
  var
    a = a
    b = b
  while true:
    a = a div 10
    b = b div 10
    if a == 0 and b == 0:
      result = 0.initBigInt
      break
    elif a == 0:
      result = 1.initBigInt
      break
    elif b == 0:
      result = -1.initBigInt
      break
assert cmpDigitLen(12.initBigInt, 86.initBigInt) == 0.initBigInt
assert cmpDigitLen(135.initBigInt, 22.initBigInt) == -1.initBigInt
assert cmpDigitLen(2983.initBigInt, 92884.initBigInt) == 1.initBigInt
assert cmpDigitLen(1.initBigInt, 2.initBigInt) == 0.initBigInt

func squareRootOfTwoApprox(iterations: Positive): MyRational =
  if iterations == 1: return MyRational(num: 3.initBigInt, den: 2.initBigInt)
  result = MyRational(num: 1.initBigInt, den: 2.initBigInt)
  for _ in 1..<iterations:
    result = MyRational(
      num: result.den,
      den: result.num + 2.initBigInt * result.den
    )
  result = MyRational(num: result.num + result.den, den: result.den)

var cnt = 0
for i in 1..1000:
  let fraction = squareRootOfTwoApprox(i)
  if cmpDigitLen(fraction.num, fraction.den) < 0:
    cnt.inc
echo cnt
