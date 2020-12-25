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
  if n == 1: return 1
  var
    lower = 1
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
