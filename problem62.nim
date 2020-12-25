from algorithm import sort

func digitLength(n: Positive): Positive =
  var n = n.int
  result = 1
  while n != 0:
    result.inc
    n = n div 10
  result.dec

# Cache cubes by digit length, search for permutations.
proc solution1 =
  const
    numberLimit = 10_000
    arrayLength = digitLength(numberLimit*numberLimit*numberLimit) + 1
  var cubes: array[arrayLength, seq[int]]
  for n in 1..<numberLimit:
    let cube = n*n*n
    cubes[digitLength(cube)].add(cube)

  for i in 0..<cubes.len:
    for n in cubes[i]:
      var
        ss: seq[int]
        ns = $n
      ns.sort
      for k in cubes[i]:
        var ks = $k
        ks.sort
        if n != k and ns == ks:
          ss.add(k)
        if ss.len == 4:
          echo n & ss
          return

# solution1()

# Cache cubes and sort their digits, find same.
proc solution2 =
  const numberLimit = 10_000
  var cubes {.noinit.}: array[numberLimit, string]
  for i in 0..<cubes.len:
    let cube = i*i*i
    var cubeString = $cube
    cubeString.sort
    cubes[i] = cubeString
  for n in 0..<cubes.len:
    var ss: seq[int]
    for k in (n+1)..<cubes.len:
      if cubes[n] == cubes[k]:
        ss.add(k*k*k)
    if ss.len == 4:
      echo n*n*n & ss
      return

solution2()
