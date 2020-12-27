from algorithm import sort
from eulers_totient import eulersProduct

const numberLimit = 10_000_000

func isPermutation(a, b: int): bool =
  var
    a = $a
    b = $b
  a.sort
  b.sort
  a == b

proc main =
  var
    minN: int
    minPhi: int
    minQuotient: float = 999_999_999.0
  for n in 2..<numberLimit:
    let
      phi = eulersProduct(n)
      quotient = n.float / phi.float
    if quotient < minQuotient and isPermutation(n, phi):
      minQuotient = quotient
      minN = n
      minPhi = phi
      echo n, " ", phi

  echo "min n: ", minN, ", min phi: ", minPhi, ", min quotient: ", minQuotient

main()
