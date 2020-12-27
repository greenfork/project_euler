func findPerfectSquareRoot*(n: uint): uint =
  ## Returns 0 if there's none.
  if n == 0: return 0
  if n == 1: return 1
  var
    lower = 1.uint
    upper = n
  result = 0
  var cnt = 0
  while upper - lower != 1:
    cnt.inc
    if cnt == 1_000_000:
      debugecho "exited findPerfectSquareRoot after 1 million iterations"
      break
    let
      middle = (lower + upper) div 2
      square = middle * middle
    if square == n:
      result = middle
      break
    elif square > n:
      upper = middle
    elif square < n:
      lower = middle
assert findPerfectSquareRoot(3481) == 59
assert findPerfectSquareRoot(3482) == 0

func findPerfectSquareRoot*(n: int): int =
  ## Returns 0 if there's none.
  if n == 0: return 0
  elif n == 1: return 1
  elif n == 2: return 0
  elif n == 3: return 0
  elif n == 4: return 2
  var
    lower = 1
    upper = block:
      if n > 1_000000000_000000000: n div 1_000000000
      elif n > 1_00000000_00000000: n div 1_00000000
      elif n > 1_0000000_0000000: n div 1_0000000
      elif n > 1_000000_000000: n div 1_000000
      elif n > 1_00000_00000: n div 1_00000
      elif n > 1_0000_0000: n div 1_0000
      elif n > 1_000_000: n div 1_000
      elif n > 1_00_00: n div 1_00
      elif n > 100: n div 10
      else: n div 2
  result = 0
  var cnt = 0
  while upper - lower != 1:
    cnt.inc
    if cnt == 1_000_000:
      debugecho "exited findPerfectSquareRoot after 1 million iterations"
      break
    let
      middle = (lower + upper) div 2
      square = middle * middle
    if square == n:
      result = middle
      break
    elif square > n:
      upper = middle
    elif square < n:
      lower = middle
assert findPerfectSquareRoot(3481) == 59
assert findPerfectSquareRoot(3482) == 0

import bigints
from strutils import parseInt

converter toInt(x: BigInt): int = parseInt($x)

func findPerfectSquareRoot*(n: BigInt): BigInt =
  ## Returns 0 if there's none.
  if n == 0.initBigInt: return 0.initBigInt
  elif n == 1.initBigInt: return 1.initBigInt
  elif n == 2.initBigInt: return 0.initBigInt
  elif n == 3.initBigInt: return 0.initBigInt
  elif n == 4.initBigInt: return 2.initBigInt
  var
    lower = 1.initBigInt
    upper = block:
      var
        square = 100.initBigInt
        sqrt = 1.initBigInt
      while n > square:
        square *= 100
        sqrt *= 10
      n div sqrt
  result = 0.initBigInt
  var cnt = 0
  while upper - lower != 1.initBigInt:
    cnt.inc
    if cnt == 1_000_000:
      debugecho "exited findPerfectSquareRoot after 1 million iterations"
      break
    let
      middle = (lower + upper) div 2
      square = middle * middle
    if square == n:
      result = middle
      break
    elif square > n:
      upper = middle
    elif square < n:
      lower = middle
assert findPerfectSquareRoot(3481.initBigInt) == 59.initBigInt
assert findPerfectSquareRoot(3482.initBigInt) == 0.initBigInt
