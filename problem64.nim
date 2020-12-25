from math import gcd

const numberLimit = 10_000
var squares {.noinit.}: array[101, int]
for i in 0..<squares.len:
  squares[i] = i*i

proc nearestSquare(n: int): (int, int) =
  for i in 0..<(squares.len - 1):
    if squares[i+1] > n:
      result = (i, squares[i])
      break

func nextIteration(
  n, num, den, nearestSquareNumber: int
): tuple[an, num, den: int] =
  var newDen = n - den*den
  let reduction = gcd(newDen, num)
  newDen = newDen div reduction
  if reduction != num:
    debugecho "error: reduction ", reduction, ", numerator: ", num
    assert false
  var
    newNum = den
    wholePart = 0
  while newNum - newDen >= -nearestSquareNumber:
    wholePart.inc
    newNum -= newDen
  result = (wholePart, newNum, newDen)

var oddCnt = 0
for n in 1..10_000:
  if n in squares: continue
  var ss: seq[int]
  let
    (number, nearestSquare) = nearestSquare(n)
    num = 1
    den = number # sqrt(n) - number
  let (an1, newNum1, newDen1) = nextIteration(n, 1, number, number)
  ss.add(an1)
  var
    newNum = -newNum1
    newDen = newDen1
  while true:
    let (anx, newNumx, newDenx) = nextIteration(n, newDen, newNum, number)
    newNum = -newNumx
    newDen = newDenx
    if newNum == -newNum1 and newDen == newDen1:
      break
    ss.add(anx)

  # echo n, ": ", ss
  if ss.len mod 2 == 1:
    oddCnt.inc

echo oddCnt
