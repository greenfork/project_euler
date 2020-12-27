from sequtils import deduplicate
from math import trunc, round
from factorization import wheelFactorization

func eulersProduct*(n: int): int =
  let factors = wheelFactorization(n).deduplicate(true)
  var product: float = 1.0
  for p in factors:
    product *= 1.0 - 1.0/p.float
  product *= n.float
  if abs(product - product.round) > 0.001:
    debugecho "Euler's product is not integer: ", product
    assert false
  result = product.round.int
assert eulersProduct(11) == 10
assert eulersProduct(87) == 56
assert eulersProduct(65) == 48
assert eulersProduct(75841) == 75184
assert eulersProduct(8319823) == 8313928

from math import gcd

func naiveIterativePhi(n: int): int =
  result = 1
  for i in 2..<n:
    if gcd(i, n) == 1:
      result.inc
assert naiveIterativePhi(11) == 10
assert naiveIterativePhi(87) == 56
assert naiveIterativePhi(65) == 48
# slow but correct
# assert naiveIterativePhi(75841) == 75184
# assert naiveIterativePhi(8319823) == 8313928
