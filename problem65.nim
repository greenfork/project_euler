import bigints

func convergents(whole: int, fractional: seq[int]): tuple[num, den: BigInt] =
  result = (1.initBigInt, fractional[^1].initBigInt)
  for i in countdown(fractional.len - 2, 0):
    result.num += fractional[i].initBigInt * result.den
    swap(result.num, result.den)
  result.num += whole.initBigInt * result.den

func digitSum(n: BigInt): BigInt =
  var n = n
  while n != 0.initBigInt:
    result += n mod 10.initBigInt
    n = n div 10.initBigInt
assert digitSum(123456.initBigInt) == 21.initBigInt

var
  ss: seq[int]
  iterNumber = 2
  cnt = 1
for i in 0..<100:
  if i mod 3 == 1:
    ss.add(iterNumber)
    iterNumber.inc(2)
  else:
    ss.add(1)
  cnt.inc
  let (num, den) = convergents(2, ss)
  echo cnt, ": ", num, "/", den
  if cnt == 100:
    echo digitSum(num)
    break
