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
