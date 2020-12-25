from perfect_square import findPerfectSquareRoot
from heaps_permutations import HeapsPermutations

func p3(n: Positive): int = n * (n + 1) div 2
func p4(n: Positive): int = n * n
func p5(n: Positive): int = n * (3*n - 1) div 2
func p6(n: Positive): int = n * (2*n - 1)
func p7(n: Positive): int = n * (5*n - 3) div 2
func p8(n: Positive): int = n * (3*n - 2)

# func p3rev(n: int): Positive = (findPerfectSquareRoot(8*n + 1) - 1) div 2
# func p4rev(n: int): Positive = findPerfectSquareRoot(n)
# func p5rev(n: int): Positive = (findPerfectSquareRoot(24*n + 1) + 1) div 6
# func p6rev(n: int): Positive = (findPerfectSquareRoot(8*n + 1) + 1) div 4
# func p7rev(n: int): Positive = (findPerfectSquareRoot(40*n + 9) + 3) div 10
# func p8rev(n: int): Positive = (findPerfectSquareRoot(3*n + 1) + 1) div 3

func cyclicNumbers(ss: openArray[int], possibleFailures: int = 0): bool =
  var failures = 0
  if ss[0] div 100 != ss[^1] mod 100:
    failures.inc
  if failures > possibleFailures: return false
  result = true
  for i in 0..<(ss.len - 1):
    if ss[i] mod 100 != ss[i+1] div 100:
      failures.inc
      if failures > possibleFailures:
        result = false
        break
assert cyclicNumbers([8128, 2882, 8281])
assert not cyclicNumbers([8281, 2882, 8128])

func cyclicNumbersOneSided(ss: openArray[int], possibleFailures: int = 0): bool =
  var failures = 0
  result = true
  for i in 0..<(ss.len - 1):
    if ss[i] mod 100 != ss[i+1] div 100:
      failures.inc
      if failures > possibleFailures:
        result = false
        break
assert cyclicNumbersOneSided([8128, 2882, 8281])
assert cyclicNumbersOneSided([8281, 8128, 2833])

func cyclicNumbersWithPermutations(
  ss: openArray[int], possibleFailures: int = 0
): seq[int] =
  for numbers in HeapsPermutations(ss):
    if cyclicNumbers(numbers, possibleFailures):
      result = @numbers
      break
assert cyclicNumbersWithPermutations([8128, 2882, 8281]) == @[8128, 2882, 8281]
assert cyclicNumbersWithPermutations([8281, 2882, 8128]) == @[2882, 8281, 8128]

func insert(ss: seq[int], n: int, pos: Natural): seq[int] =
  for i, item in ss.pairs:
    if pos == i:
      result.add n
    result.add item
  if pos == ss.len:
    result.add n
assert insert(@[1, 2, 3], 5, 0) == @[5, 1, 2, 3]
assert insert(@[1, 2, 3], 5, 1) == @[1, 5, 2, 3]
assert insert(@[1, 2, 3], 5, 2) == @[1, 2, 5, 3]
assert insert(@[1, 2, 3], 5, 3) == @[1, 2, 3, 5]

func cyclicNumbersWithInsertion(
  ss: openArray[int], insertion: int, possibleFailures: int = 0
): seq[int] =
  for i in 0..ss.len:
    let numbers = @ss.insert(insertion, i)
    if cyclicNumbers(numbers, possibleFailures):
      result = numbers
      break

var
  p3Start, p3End, p4Start, p4End, p5Start, p5End, p6Start, p6End,
    p7Start, p7End, p8Start, p8End: int
  p3arr, p4arr, p5arr, p6arr, p7arr, p8arr: array[1_001, int]
for i in 1..1_000:
  let
    p3 = p3(i)
    p4 = p4(i)
    p5 = p5(i)
    p6 = p6(i)
    p7 = p7(i)
    p8 = p8(i)
  p3arr[i] = p3
  p4arr[i] = p4
  p5arr[i] = p5
  p6arr[i] = p6
  p7arr[i] = p7
  p8arr[i] = p8
  if p3Start == 0 and p3 >= 1000:
    p3Start = i
  if p3End == 0 and p3Start != 0 and p3 > 9999:
    p3End = i
  if p4Start == 0 and p4 >= 1000:
    p4Start = i
  if p4End == 0 and p4Start != 0 and p4 > 9999:
    p4End = i
  if p5Start == 0 and p5 >= 1000:
    p5Start = i
  if p5End == 0 and p5Start != 0 and p5 > 9999:
    p5End = i
  if p6Start == 0 and p6 >= 1000:
    p6Start = i
  if p6End == 0 and p6Start != 0 and p6 > 9999:
    p6End = i
  if p7Start == 0 and p7 >= 1000:
    p7Start = i
  if p7End == 0 and p7Start != 0 and p7 > 9999:
    p7End = i
  if p8Start == 0 and p8 >= 1000:
    p8Start = i
  if p8End == 0 and p8Start != 0 and p8 > 9999:
    p8End = i

# echo p3Start, " ", p3End
# echo p4Start, " ", p4End
# echo p5Start, " ", p5End
# echo p6Start, " ", p6End
# echo p7Start, " ", p7End
# echo p8Start, " ", p8End

echo (p3End - p3Start) * (p4End - p4Start) * (p5End - p5Start) *
     (p6End - p6Start) * (p7End - p7Start) * (p8End - p8Start)

# Computes in 6 seconds.
proc solution1 =
  var cnt = 0
  for p3n in p3Start..<p3End:
    let p3 = p3arr[p3n]
    for p4n in p4Start..<p4End:
      if p4n == p3n: continue
      let p4 = p4arr[p4n]
      for p5n in p5Start..<p5End:
        if p5n == p3n or p5n == p4n: continue
        let p5 = p5arr[p5n]
        for p6n in p6Start..<p6End:
          if p6n == p3n or p6n == p4n or p6n == p5n: continue
          let
            p6 = p6arr[p6n]
            cwp6 = cyclicNumbersWithPermutations([p3, p4, p5, p6], 2)
          if cwp6 == @[]: continue
          for p7n in p7Start..<p7End:
            if p7n == p3n or p7n == p4n or p7n == p5n or p7n == p6n: continue
            let
              p7 = p7arr[p7n]
              cwp7 = cyclicNumbersWithInsertion(cwp6, p7, 1)
            if cwp7 == @[]: continue
            for p8n in p8Start..<p8End:
              if p8n == p3n or p8n == p4n or p8n == p5n or p8n == p6n or
                 p8n == p7n: continue
              let
                p8 = p8arr[p8n]
                cwp8 = cyclicNumbersWithInsertion(cwp7, p8)
              if cwp8 == @[]: continue
              echo cnt, ": ", cwp8

# solution1()

type
  PentagonalNumbers = object
    arr: ptr array[1001, int]
    s, e: int

# Computes in 20 ms.
proc solution2 =
  let initialOrder = [
    PentagonalNumbers(arr: p3arr.addr, s: p3Start, e: p3End),
    PentagonalNumbers(arr: p4arr.addr, s: p4Start, e: p4End),
    PentagonalNumbers(arr: p5arr.addr, s: p5Start, e: p5End),
    PentagonalNumbers(arr: p6arr.addr, s: p6Start, e: p6End),
    PentagonalNumbers(arr: p7arr.addr, s: p7Start, e: p7End),
    PentagonalNumbers(arr: p8arr.addr, s: p8Start, e: p8End),
  ]
  var cnt = 0
  for pp in HeapsPermutations(initialOrder):
    for pn0 in pp[0].s..<pp[0].e:
      let p0 = pp[0].arr[pn0]
      for pn1 in pp[1].s..<pp[1].e:
        if pn1 == pn0: continue
        let p1 = pp[1].arr[pn1]
        if not cyclicNumbersOneSided([p0, p1]): continue
        for pn2 in pp[2].s..<pp[2].e:
          if pn2 == pn0 or pn2 == pn1: continue
          let p2 = pp[2].arr[pn2]
          if not cyclicNumbersOneSided([p0, p1, p2]): continue
          for pn3 in pp[3].s..<pp[3].e:
            if pn3 == pn0 or pn3 == pn1 or pn3 == pn2: continue
            let p3 = pp[3].arr[pn3]
            if not cyclicNumbersOneSided([p0, p1, p2, p3]): continue
            for pn4 in pp[4].s..<pp[4].e:
              if pn4 == pn0 or pn4 == pn1 or pn4 == pn2 or pn4 == pn3: continue
              let p4 = pp[4].arr[pn4]
              if not cyclicNumbersOneSided([p0, p1, p2, p3, p4]): continue
              for pn5 in pp[5].s..<pp[5].e:
                if pn5 == pn0 or pn5 == pn1 or pn5 == pn2 or pn5 == pn3 or
                   pn5 == pn4: continue
                let p5 = pp[5].arr[pn5]
                if not cyclicNumbers([p0, p1, p2, p3, p4, p5]): continue
                echo cnt, ": ", [p0, p1, p2, p3, p4, p5], ", sum: ",
                     p0+p1+p2+p3+p4+p5
                cnt.inc

solution2()
