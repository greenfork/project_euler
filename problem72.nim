from eulers_totient import eulersProduct

# Sum of Euler's Totient functions
proc solution1() =
  const numberLimit = 1000_000
  var sum = 0
  for d in 2..numberLimit:
    sum += eulersProduct(d)
  echo sum

solution1()
