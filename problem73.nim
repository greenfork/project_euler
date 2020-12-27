import rationals
from math import round, gcd
from algorithm import sort

const
  lowerBoundRational = 1//3
  upperBoundRational = 1//2
  lowerBound = 1.0 / 3.0
  upperBound = 1.0 / 2.0

proc solution1 =
  const numberLimit = 12000
  var cnt = 0
  var fractions: seq[Rational[int]]
  for d in 2..numberLimit:
    let nLower = (d div 3) + 1
    let nUpper =
      if d mod 2 == 0: (d div 2) - 1
      else: d div 2
    for n in nLower..nUpper:
      if gcd(n, d) == 1:
        cnt.inc
        # fractions.add(n//d)
  # fractions.sort
  # echo fractions
  echo cnt

solution1()
