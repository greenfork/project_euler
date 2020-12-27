from math import gcd

# Naive approach.
# Never computes.
proc solution1 =
  const numberLimit = 10_000
  var
    maxQuotient: float
    maxN: int
  for n in 2..numberLimit:
    var relativelyPrimesCount = 1
    for i in 2..<n:
      if gcd(n, i) == 1: relativelyPrimesCount.inc
    let quotient = n.float / relativelyPrimesCount.float
    # echo n, ", ", relativelyPrimesCount, ": ", quotient
    if quotient > maxQuotient:
      maxQuotient = quotient
      maxN = n
  echo "\nmax n: ", maxN, ", max quotient: ", maxQuotient

# solution1()

# Using Euler's product formulae.

from sequtils import deduplicate
from math import trunc, round
from factorization import wheelFactorization

func eulersProduct(n: int): int =
  let factors = wheelFactorization(n).deduplicate(true)
  var product: float = 1.0
  for p in factors:
    product *= 1.0 - 1.0/p.float
  product *= n.float
  if abs(product - product.round) > 0.001:
    debugecho "Euler's product is not integer: ", product
    assert false
  result = product.round.int

proc solution2 =
  const numberLimit = 1_000_000
  var
    maxQuotient: float
    maxN: int
  for n in 2..numberLimit:
    let
      phi = eulersProduct(n)
      quotient = n.float / phi.float
    if quotient > maxQuotient:
      maxQuotient = quotient
      maxN = n
  echo "\nmax n: ", maxN, ", max quotient: ", maxQuotient

solution2()
