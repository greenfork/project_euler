#[
An irrational decimal fraction is created by concatenating the positive integers:

0.123456789101112131415161718192021...

It can be seen that the 12th digit of the fractional part is 1.

If dn represents the nth digit of the fractional part, find the value of the following expression.

d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000
]#

var s = ""
for i in 1..1_000_000:
  s.add $i

func charToInt(ch: char): int = ch.ord - '0'.ord

let
  d1       = charToInt s[0]
  d10      = charToInt s[9]
  d100     = charToInt s[99]
  d1000    = charToInt s[999]
  d10000   = charToInt s[9999]
  d100000  = charToInt s[99999]
  d1000000 = charToInt s[999999]
  product = d1 * d10 * d100 * d1000 * d10000 * d100000 * d1000000

echo product
