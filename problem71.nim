from math import gcd
from algorithm import sort, binarySearch
import rationals

# Naive implementation.
# Never computes.
proc solution1 =
  const numberLimit = 500
  var fractions: seq[Rational[int]]
  for d in 2..numberLimit:
    for n in 1..<d:
      if gcd(d, n) == 1:
        fractions.add(n//d)
  fractions.sort
  echo fractions
  let index37 = fractions.binarySearch(3//7, rationals.cmp[Rational[int]])
  echo fractions[index37 - 1]

# solution1()

# Find close numbers to 3/7
# Never computes.
proc solution2 =
  const numberLimit = 10_000
  var fractions: seq[Rational[int]]
  for d in 2..numberLimit:
    for n in 1..<d:
      let fraction = n//d
      if fraction > 3//7: continue
      if fraction == 3//7 or 3//7 - fraction > 1//10_000: continue
      # echo fraction
      if gcd(d, n) == 1:
        fractions.add(n//d)
  fractions.sort
  echo fractions
  let index37 = fractions.binarySearch(3//7, rationals.cmp[Rational[int]])
  echo fractions[index37 - 1]

# solution2()

from math import round

# Find nearest number to 3/7 by going from top to bottom.
proc solution3 =
  const
    numberLimit = 1_000_000
    targetFraction: float = 3.0 / 7.0
    targetFractionRational = 3//7
  # var fractions: seq[Rational[int]] = @[3//7]
  var
    minFraction: Rational[int]
    minDifference: Rational[int] = 1//2
  for d in 10..numberLimit:
    let closestNumerator = int(round(targetFraction * d.float))
    var closestCoprimeNumerator = closestNumerator
    for n in countdown(closestNumerator + 1, 0):
      if n//d < targetFractionRational and gcd(n, d) == 1:
        closestCoprimeNumerator = n
        break
    let difference = targetFractionRational - closestCoprimeNumerator//d
    if difference < minDifference:
      minDifference = difference
      minFraction = closestCoprimeNumerator//d
    # fractions.add(closestCoprimeNumerator//d)
  # fractions.sort
  # echo fractions
  # let index37 = fractions.binarySearch(3//7, rationals.cmp[Rational[int]])
  # echo fractions[index37 - 1]
  echo minFraction, " ", minDifference

solution3()

# for 100_000 it is 42857/100000
# for 10_000 it is 4283/9994
# for 1000 it is 428/999
# for 500 it is 212/495
# for 100 it is 41/96
# for 10 it is 2/5
