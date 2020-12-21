func factorial(n: Natural): int =
  if n == 0: return 1
  result = 1
  var n = n
  while n > 1:
    result *= n
    n.dec

func combinatoricSelection(n, r: Natural): int =
  assert n >= r
  result = 1
  let
    divider1 = r
    divider2 = n - r
  var
    maxDivider: int
    minDivider: int
  if divider1 > divider2:
    maxDivider = divider1
    minDivider = divider2
  else:
    minDivider = divider1
    maxDivider = divider2
  let fact = factorial(minDivider)
  for i in (maxDivider + 1)..n:
    result *= i
  result = result div fact

var total = 0
for n in 1..100:
  var
    cnt2 = 0
  for r in 0..n:
    let cnr = combinatoricSelection(n, r)
    # echo "n: ", n, ", r: ", r, ", cnr: ", cnr
    if cnr > 1_000_000:
      let half = n div 2
      if n mod 2 == 0:
        cnt2 += (half - r) * 2 + 1
      else:
        cnt2 += (half - r + 1) * 2
      break
  # echo cnt2
  total += cnt2
echo total
