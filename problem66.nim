from math import sqrt, trunc
from sequtils import toSeq
from algorithm import sort
import intsets
from strutils import parseInt
from perfect_square import findPerfectSquareRoot
import bigints

func eq(D, x, y: int): bool =
  x*x - D*y*y == 1
assert eq(2, 3, 2)

# First 3 solutions are wrong because they minimise Y, whereasa X should be
# minimised. And sqrt doesn't work for big numbers probably due to precision.

# Naive iterations.
# Computes in a minute.
proc solution1 =
  const numberLimit = 100_000_000
  var
    notFoundCnt = 0
    maxX = 0
    maxY = 0
    maxD = 0
  for D in 61..61:
    let Dsqrt = sqrt(D.float)
    if Dsqrt == Dsqrt.trunc: continue
    # debugecho D
    var found = false
    for y in 1..<numberLimit:
      let
        allegedSquare = D*y*y + 1
        square = sqrt(allegedSquare.float)
      if square == square.trunc:
        echo "alleged: ", allegedSquare
        echo "square: ", square
        let square = square.int
        # echo square, "^2 - ", D, "x", y, "^2 = 1"
        if square > maxX:
          maxX = square
          maxY = y
          maxD = D
        found = true
        if not eq(D, square, y):
          echo "wrong solution: ", [D, square, y]
          echo square, "^2 - ", D, "x", y, "^2 = ", square*square - D*y*y
          return
        break
    if not found:
      # debugecho D, ": not found"
      notFoundCnt.inc
  # echo "not found total: ", notFoundCnt
  echo "maximum X: ", maxX
  echo "maximum Y: ", maxY
  echo "maximum D: ", maxD

# solution1()

# Compute by leveling up higher limit for y.
# Computes in a minute.
proc solution2 =
  var
    lowerBound = 1
    upperBound = 10
    notFoundCnt = -1
    notFoundDs = (1..1000).toSeq.toIntSet
    maxX = 0
  for i in 1..1000:
    notFoundDs.excl i*i
  while notFoundDs.card != 0:
    # echo "cardinality: ", notFoundDs.card
    # echo "not found: ", notFoundCnt
    # echo lowerBound, "..", upperBound
    notFoundCnt = 0
    for D in notFoundDs:
      let Dsqrt = sqrt(D.float)
      if Dsqrt == Dsqrt.trunc: continue
      var found = false
      for y in lowerBound..<upperBound:
        let
          allegedSquare = D*y*y + 1
          square = sqrt(allegedSquare.float)
        if square == square.trunc:
          let square = square.int
          # echo square, "^2 - ", D, "x", y, "^2 = 1"
          found = true
          notFoundDs.excl D
          if square > maxX: maxX = square
          break
      if not found:
        # debugecho D, ": not found"
        notFoundCnt.inc
    lowerBound *= 10
    upperBound *= 10
  echo "maximum X: ", maxX

# solution2()

# Naive iterations inverted.
# Computes too long.
proc solution3 =
  const numberLimit = 100_000_000
  var
    notFoundCnt = 0
    maxX = 0
    dseq = (1..1000).toSeq.toIntSet
  for y in 1..<numberLimit:
    var found = false
    for D in dseq:
      let Dsqrt = sqrt(D.float)
      if Dsqrt == Dsqrt.trunc:
        dseq.excl(D)
        continue
      # debugecho D
      let
        allegedSquare = D*y*y + 1
        square = sqrt(allegedSquare.float)
      if square == square.trunc:
        let square = square.int
        # echo square, "^2 - ", D, "x", y, "^2 = 1"
        if square > maxX: maxX = square
        found = true
        dseq.excl(D)
        break
    if not found:
      # debugecho D, ": not found"
      notFoundCnt.inc
  # echo "not found total: ", notFoundCnt
  echo "maximum X: ", maxX

# solution3()

func eq(D, x, y: BigInt): bool =
  x*x - D*y*y == 1.initBigInt
assert eq(2.initBigInt, 3.initBigInt, 2.initBigInt)

# Naive iterations.
# Computes in never.
proc solution4 =
  const numberLimit = 10_000_000_000
  var
    notFoundCnt = 0
    maxX: BigInt = 0.initBigInt
    maxY: BigInt = 0.initBigInt
    maxD: BigInt = 0.initBigInt
  for D in 61..61:
  # for D in [109, 149, 151, 157, 166, 181, 193, 199]:
    let Dsqrt = sqrt(D.float)
    if Dsqrt == Dsqrt.trunc: continue
    # debugecho D
    let DBig = D.initBigInt
    var found = false
    # for x in 2..<numberLimit:
    for x in 1_766_319_049..1766319049:
      let xBig = x.initBigInt
      let num = xBig*xBig - 1
      if num mod DBig != 0: continue
      let
        allegedSquare = num div DBig
        square = findPerfectSquareRoot(allegedSquare)
      if square != 0:
        # echo "alleged: ", allegedSquare
        # echo "square: ", square
        let y = square
        echo x, "^2 - ", D, "x", y, "^2 = 1"
        if xBig > maxX:
          maxX = xBig
          maxY = y
          maxD = DBig
        found = true
        if not eq(DBig, xBig, y):
          echo "wrong solution: ", [DBig, xBig, y]
          echo xBig, "^2 - ", DBig, "x", y, "^2 = ", xBig*xBig - DBig*y*y
          return
        break
    if not found:
      debugecho D, ": not found"
      notFoundCnt.inc
  echo "not found total: ", notFoundCnt
  echo "maximum X: ", maxX
  echo "maximum Y: ", maxY
  echo "maximum D: ", maxD

# solution4()

# Chakravala method https://en.wikipedia.org/wiki/Chakravala_method

func closestSquare(n: int): int =
  for i in 1..<n:
    let
      square = i*i
      nextSquare = (i+1)*(i+1)
    if n == square:
      result = i - 1
      break
    elif square < n and n < nextSquare:
      result = i
      break
assert closestSquare(64) == 7
assert closestSquare(67) == 8

func firstIterationNumber(x, y, k: BigInt): int =
  for m in 1..10_000_000_000:
    let mBig = m.initBigInt
    if (x + y*mBig) mod k == 0.initBigInt:
      result = m.int
      break

func abs(n: BigInt): BigInt =
  if n < 0.initBigInt:
    result = -n
  else:
    result = n

# Computes very fast.
proc solution5 =
  const mLimit = 1_000_000_000
  var
    x0, y0, k0: BigInt
    x1, y1, k1: BigInt
    maxX = 0.initBigInt
    maxD: int
  for D in 2..1000:
    let Dsqrt = sqrt(D.float)
    if Dsqrt == Dsqrt.trunc: continue
    let DBig = D.initBigInt
    x0 = closestSquare(D).initBigInt
    y0 = 1.initBigInt
    k0 = x0*x0 - D.initBigInt*y0*y0
    while k0 != 1.initBigInt:
      let
        firstIter = firstIterationNumber(x0, y0, k0)
        addition = parseInt($abs(k0))
      var
        m: int
        closesDifference = 999_999_999_999
      for mn in countup(firstIter, mLimit, addition):
        let difference = abs(mn*mn - D)
        if difference < closesDifference:
          closesDifference = difference
          m = mn
        elif difference > closesDifference:
          break
      let mBig = m.initBigInt
      x1 = (x0*mBig + DBig*y0) div abs(k0)
      y1 = (x0 + y0*mBig) div abs(k0)
      k1 = (mBig*mBig - DBig) div k0
      x0 = x1
      y0 = y1
      k0 = k1
      if x0 > maxX:
        maxX = x0
        maxD = D
    echo x0, "^2 - ", D, "x", y0, "^2 = 1"
    if not eq(DBig, x0, y0): assert false
  echo "maximum x: ", maxX
  echo "maximum D: ", maxD

solution5()
