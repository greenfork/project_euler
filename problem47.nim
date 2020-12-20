#[
The first two consecutive numbers to have two distinct prime factors are:

14 = 2 × 7
15 = 3 × 5

The first three consecutive numbers to have three distinct prime factors are:

644 = 2² × 7 × 23
645 = 3 × 5 × 43
646 = 2 × 17 × 19.

Find the first four consecutive integers to have four distinct prime factors each.
What is the first of these numbers?
]#

from sequtils import deduplicate
from factorization import wheelFactorization

for i in 1..1_000_000:
  let
    i = i.uint
    factors1 = wheelFactorization(i).deduplicate(isSorted = true)
    factors2 = wheelFactorization(i+1).deduplicate(isSorted = true)
    factors3 = wheelFactorization(i+2).deduplicate(isSorted = true)
    factors4 = wheelFactorization(i+3).deduplicate(isSorted = true)
  if factors1.len == 4 and factors2.len == 4 and
     factors3.len == 4 and factors4.len == 4:
    echo i
    break
