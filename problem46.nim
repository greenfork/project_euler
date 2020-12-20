#[
It was proposed by Christian Goldbach that every odd composite number can be
written as the sum of a prime and twice a square.

9 = 7 + 2×12
15 = 7 + 2×22
21 = 3 + 2×32
25 = 7 + 2×32
27 = 19 + 2×22
33 = 31 + 2×12

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime
and twice a square?
]#

from eratosthenes import primesArray

block solution:
  for i in 2..<primesArray.len:
    if primesArray[i] == false and i mod 2 == 1:
      block search:
        var found = false
        for p in 0..<primesArray.len:
          if primesArray[p] == true and p < i:
            let withoutPrime = i - p
            for s in 1..1_000:
              if withoutPrime == 2*s*s:
                echo "i: ", i, ", p: ", p, ", s: ", s
                found = true
                break search
        if not found:
          echo "i: ", i
          break solution
