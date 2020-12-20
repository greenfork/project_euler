from algorithm import sort
from eratosthenes import primesArray

func digits(n: int): seq[int] =
  var n = n
  while n != 0:
    result.add n mod 10
    n = n div 10
assert digits(1235) == @[5, 3, 2, 1]

for n in 1000..7000:
  if primesArray[n] == true:
    for k in 1000..4500:
      let
        a1 = n
        a2 = n + k
        a3 = n + k + k
      if a3 > 10_000: break
      if primesArray[a2] == true and primesArray[a3] == true:
        var
          digits1 = digits(a1)
          digits2 = digits(a2)
          digits3 = digits(a3)
        digits1.sort
        digits2.sort
        digits3.sort
        if digits1 == digits2 and digits1 == digits3:
          echo "a1: ", a1, ", a2: ", a2, ", a3: ", a3, ", k: ", k
