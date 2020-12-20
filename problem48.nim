const modulo = 10_000_000_000.uint # last 10 digits

var sum: uint = 0
for i in 1..1000:
  var n = i.uint
  for _ in 1..<i:
    n = n * i.uint mod modulo
  sum = (sum + n) mod modulo
echo sum
