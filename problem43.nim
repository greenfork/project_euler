#[
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of
each of the digits 0 to 9 in some order, but it also has a rather interesting
sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note
the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17

Find the sum of all 0 to 9 pandigital numbers with this property.
]#

from strutils import parseInt
from heaps_permutations import HeapsPermutations

func substringDivisible(s: string): bool =
  parseInt(s[1..3]) mod 2 == 0 and
  parseInt(s[2..4]) mod 3 == 0 and
  parseInt(s[3..5]) mod 5 == 0 and
  parseInt(s[4..6]) mod 7 == 0 and
  parseInt(s[5..7]) mod 11 == 0 and
  parseInt(s[6..8]) mod 13 == 0 and
  parseInt(s[7..9]) mod 17 == 0
assert substringDivisible("1406357289")

var substringDivisibleSum = 0
for perm in HeapsPermutations("0123456789"):
  if perm[0] == '0': continue
  if substringDivisible(perm):
    substringDivisibleSum += parseInt(perm)

echo substringDivisibleSum
