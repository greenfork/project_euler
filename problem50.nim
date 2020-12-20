from eratosthenes import primesArray

const limit = 1_000_000

var
  sum: int
  primes: seq[int]

for n in 0..<limit:
  if primesArray[n] == false:
    continue
  sum = 0
  primes = @[]
  for i in n..<limit:
    if primesArray[i] == true:
      sum += i
      primes.add i
      if sum > limit:
        break
      elif sum < limit and primesArray[sum] and primes.len > 540:
        echo "sum: ", sum, ", length: ", primes.len
        # echo primes
