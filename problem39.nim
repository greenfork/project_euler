#[
If p is the perimeter of a right angle triangle with integral length sides,
{a,b,c}, there are exactly three solutions for p = 120.

{20,48,52}, {24,45,51}, {30,40,50}

For which value of p ≤ 1000, is the number of solutions maximised?
]#

const perimeterLimit = 1000

func findAllSolutions(perimeter: int): seq[seq[int]] =
  for a in 1..<perimeter:
    for b in 1..<(perimeter - a):
      let c = perimeter - a - b
      if c*c == a*a + b*b:
        result.add @[a, b, c]
assert findAllSolutions(120) ==
  @[@[20, 48, 52], @[24, 45, 51], @[30, 40, 50], @[40, 30, 50], @[45, 24, 51], @[48, 20, 52]]

var
  largestNumberOfSolutions = 0
  answer: int
for p in 1..perimeterLimit:
  let solutions = findAllSolutions(p)
  if solutions.len > largestNumberOfSolutions:
    largestNumberOfSolutions = solutions.len
    answer = p

echo answer
