#[
Take the number 192 and multiply it by each of 1, 2, and 3:

192 × 1 = 192
192 × 2 = 384
192 × 3 = 576

By concatenating each product we get the 1 to 9 pandigital, 192384576.
We will call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5,
giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the
concatenated product of an integer with (1,2, ... , n) where n > 1?
]#

func concatenatedProduct(n: int, highestMultiplier: int): string =
  for multiplier in 1..highestMultiplier:
    result.add $(n * multiplier)
assert concatenatedProduct(192, 3) == "192384576"
assert concatenatedProduct(9, 5) == "918273645"

func oneToNinePandigital(n: string): bool =
  if n.len != 9:
    result = false
  else:
    var numbers = {'1'..'9'}
    for ch in n:
      if ch notin numbers:
        return false
      else:
        numbers.excl ch
    result = true
assert oneToNinePandigital("192384576")
assert oneToNinePandigital("918273645")
assert not oneToNinePandigital("18273645")
assert not oneToNinePandigital("9918273645")
assert not oneToNinePandigital("918273644")

func `>`(a, b: string): bool =
  assert a.len == b.len
  for i in 0..<a.len:
    if a[i] > b[i]:
      return true

var largestPandigital = "123456789"
for i in 1..10_000:
  for k in 1..1_000:
    let product = concatenatedProduct(i, k)
    if product.len > 9: break
    if oneToNinePandigital(product) and product > largestPandigital:
      largestPandigital = product

echo largestPandigital
