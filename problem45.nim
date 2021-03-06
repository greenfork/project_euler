#[
Triangle, pentagonal, and hexagonal numbers are generated by the following formulae:

Triangle	 	Tn=n(n+1)/2	 	1, 3, 6, 10, 15, ...
Pentagonal	Pn=n(3n−1)/2	1, 5, 12, 22, 35, ...
Hexagonal	 	Hn=n(2n−1)	 	1, 6, 15, 28, 45, ...
It can be verified that T285 = P165 = H143 = 40755.

Find the next triangle number that is also pentagonal and hexagonal.
]#

from perfect_square import findPerfectSquareRoot

func isPentagonalNumber(n: uint): bool =
  findPerfectSquareRoot(24*n + 1) mod 6 == 5

func hexagonalNumber(n: uint): uint =
  n * (2 * n - 1)

for i in 144..1_000_000:
  let hexagonal = hexagonalNumber(i.uint)
  if isPentagonalNumber(hexagonal):
    echo hexagonal
    break
