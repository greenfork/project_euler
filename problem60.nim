from strutils import parseInt
from eratosthenes import isPrime, primesArray

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

var total = 10_000
# let primesArray = primesArray[0..100_000]
block solution:
  for a in 0..<primesArray.len:
    if not primesArray[a]: continue
    if a > total: break
    echo a
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
