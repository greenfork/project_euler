import intsets
from strutils import parseInt
from eratosthenes import isPrime, primesArray, primesIterator

# 3, 7, 109, 673

proc areGoodPrimes(primes: openArray[int]): bool =
  result = true
  for i in 0..<primes.len:
    for k in (i+1)..<primes.len:
      let
        number1 = parseInt($primes[i] & $primes[k])
        number2 = parseInt($primes[k] & $primes[i])
      if not isPrime(number1) or not isPrime(number2):
        return false
assert areGoodPrimes([3, 7, 109, 673])
assert areGoodPrimes([3, 7, 823, 121441, 912763])

# Never computes.
# Naive iterative approach.
proc solution1 =
  var total = 1_000_000
  for a in 0..<primesArray.len:
    if not primesArray[a]: continue
    if a > total: break
    for b in (a+1)..<primesArray.len:
      if not primesArray[b] or
         not areGoodPrimes([a, b]):
        continue
      if a + b > total: break
      for c in (b+1)..<primesArray.len:
        if not primesArray[c] or
           not areGoodPrimes([a, b, c]):
          continue
        if a + b + c > total: break
        for d in (c+1)..<primesArray.len:
          if not primesArray[d] or
             not areGoodPrimes([a, b, c, d]):
            continue
          if a + b + c + d > total: break
          for e in (d+1)..<primesArray.len:
            if not primesArray[e] or
               not areGoodPrimes([a, b, c, d, e]):
              continue
            let sum = a+b+c+d+e
            if sum > total: break
            total = sum
            echo a, " ", b, " ", c, " ", d, " ", e, ", sum: ", sum

# solution1()

# Never computes.
# Solve for 2 and for 3 primes, try to combine to get 5 primes total.
proc solution2 =
  const numberLimit = 2000
  var cnt1 = 0
  var triples: seq[tuple[a, b, c: int]]
  for a in 0..<primesArray.len:
    if not primesArray[a]: continue
    if a > numberLimit: break
    for b in (a+1)..<primesArray.len:
      if not primesArray[b]: continue
      if b > numberLimit: break
      if not areGoodPrimes([a, b]): continue
      for c in (b+1)..<primesArray.len:
        if not primesArray[c]: continue
        if c > numberLimit: break
        if not areGoodPrimes([a, b, c]): continue
        # echo cnt1, ": ", a, ", ", b, ", ", c
        cnt1.inc
        triples.add((a, b, c))
  var cnt2 = 0
  var doubles: seq[tuple[d, e: int]]
  for a in 0..<primesArray.len:
    if not primesArray[a]: continue
    if a > numberLimit: break
    for b in (a+1)..<primesArray.len:
      if not primesArray[b]: continue
      if b > numberLimit: break
      if not areGoodPrimes([a, b]): continue
      # echo cnt2, ": ", a, ", ", b
      cnt2.inc
      doubles.add((a, b))
  for (a, b, c) in triples:
    for (d, e) in doubles:
      if a == d or a == e or b == d or b == e or c == d or c == e: continue
      if not areGoodPrimes([a, b, c, d, e]): continue
      echo [a, b, c, d, e]

# solution2()

# Computes in 700ms.
# Cache every number's possible pairs, chain them like a snake.
proc solution3 =
  const numberLimit = 10_000
  var cachedPairs: array[numberLimit, seq[int]]
  for a in 0..<primesArray.len:
    if not primesArray[a]: continue
    if a > numberLimit: break
    for b in (a+1)..<primesArray.len:
      if not primesArray[b]: continue
      if b > numberLimit: break
      let
        number1 = parseInt($a & $b)
        number2 = parseInt($b & $a)
      if not isPrime(number1) or not isPrime(number2): continue
      cachedPairs[a].add(b)
      cachedPairs[b].add(a)
  for a in 0..<primesArray.len:
    if not primesArray[a]: continue
    if a > numberLimit: break
    for b in cachedPairs[a]:
      for c in cachedPairs[b]:
        if c notin cachedPairs[a]: continue
        for d in cachedPairs[c]:
          if d notin cachedPairs[a] or d notin cachedPairs[b]: continue
          for e in cachedPairs[d]:
            if e notin cachedPairs[a] or e notin cachedPairs[b] or
               e notin cachedPairs[c]: continue
            echo [a, b, c, d, e], ", sum: ", a+b+c+d+e

solution3()

# Compile with --gc:orc, computes in 700ms. Compiles in 16 seconds(!).
# Cache every number's possible pair and chain them using set intersection.
proc solution4 =
  const numberLimit = 10_000
  var cachedSets: array[numberLimit, IntSet]
  for a in 0..<primesArray.len:
    if not primesArray[a]: continue
    if a > numberLimit: break
    for b in (a+1)..<primesArray.len:
      if not primesArray[b]: continue
      if b > numberLimit: break
      let
        number1 = parseInt($a & $b)
        number2 = parseInt($b & $a)
      if not isPrime(number1) or not isPrime(number2): continue
      cachedSets[a].incl(b)
      cachedSets[b].incl(a)
  for a in 0..<primesArray.len:
    if not primesArray[a]: continue
    if a > numberLimit: break
    for b in cachedSets[a]:
      for c in (cachedSets[a] * cachedSets[b]):
        for d in (cachedSets[a] * cachedSets[b] * cachedSets[c]):
          for e in (cachedSets[a] * cachedSets[b] * cachedSets[c] * cachedSets[d]):
            echo [a, b, c, d, e]

# solution4()
