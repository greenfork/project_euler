func wheelFactorization*(n: uint): seq[uint] =
  # {2, 3, 5} is basis
  # {7, 11, 13, 17, 19, 23, 29, 31} is first turn
  const increments = [4.uint, 2.uint, 4.uint, 2.uint, 4.uint, 6.uint,
                      2.uint, 6.uint]
  var n = n
  while n mod 2 == 0:
    result.add 2
    n = n div 2
  while n mod 3 == 0:
    result.add 3
    n = n div 3
  while n mod 5 == 0:
    result.add 5
    n = n div 5
  var
    k: uint = 7
    i: uint = 0
  while k*k <= n:
    if n mod k == 0:
      result.add k
      n = n div k
    else:
      k += increments[i]
      if i < increments.len - 1: i.inc
      else: i = 0
  if n != 1: result.add n
assert wheelFactorization(2*3*5) == @[2.uint, 3.uint, 5.uint]
assert wheelFactorization(2*2*3*7*13*29) ==
  @[2.uint, 2.uint, 3.uint, 7.uint, 13.uint, 29.uint]

func wheelFactorization*(n: int): seq[int] =
  # {2, 3, 5} is basis
  # {7, 11, 13, 17, 19, 23, 29, 31} is first turn
  const increments = [4, 2, 4, 2, 4, 6, 2, 6]
  var n = n
  while n mod 2 == 0:
    result.add 2
    n = n div 2
  while n mod 3 == 0:
    result.add 3
    n = n div 3
  while n mod 5 == 0:
    result.add 5
    n = n div 5
  var
    k = 7
    i = 0
  while k*k <= n:
    if n mod k == 0:
      result.add k
      n = n div k
    else:
      k += increments[i]
      if i < increments.len - 1: i.inc
      else: i = 0
  if n != 1: result.add n
assert wheelFactorization(2*3*5) == @[2, 3, 5]
assert wheelFactorization(2*2*3*7*13*29) == @[2, 2, 3, 7, 13, 29]
