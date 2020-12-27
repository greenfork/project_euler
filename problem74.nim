from math import fac

const numberLimit = 1000_000

func digitFac(n: int): int =
  var n = n
  while n != 0:
    result += fac(n mod 10)
    n = n div 10
assert digitFac(3) == 6
assert digitFac(145) == 145
assert digitFac(169) == 363601
assert digitFac(363601) == 1454
assert digitFac(1454) == 169

# const cycleFactorialsMemoizeLength = digitFac(numberLimit - 1) + 1
const cycleFactorialsMemoizeLength = 10_000_000
var cycleFactorialsMemoize: array[cycleFactorialsMemoizeLength, int]
proc cycleFactorials(n: int): int =
  ## Returns number of non-repeating numbers.
  if cycleFactorialsMemoize[n] != 0: return cycleFactorialsMemoize[n]
  var
    terms: seq[int] = @[n]
    term: int
    n = n
  result = 1
  while true:
    term = digitFac(n)
    n = term
    if term in terms:
      break
    elif cycleFactorialsMemoize[n] != 0:
      return cycleFactorialsMemoize[n] + result
    else:
      result.inc
      terms.add term
  let repeatingTermIndex = terms.find(term)
  # echo terms, ", ", repeatingTermIndex
  for i in 0..<terms.len:
    if i < repeatingTermIndex:
      cycleFactorialsMemoize[terms[i]] = result - i
    else:
      cycleFactorialsMemoize[terms[i]] = result - repeatingTermIndex
assert cycleFactorials(69) == 5
assert cycleFactorials(78) == 4
assert cycleFactorials(169) == 3

proc solution1 =
  var cnt = 0
  for n in 2..<numberLimit:
    let cycles = cycleFactorials(n)
    if cycles == 60:
      cnt.inc
    elif cycles > 60:
      assert false
  echo cnt

solution1()
# echo cycleFactorialsMemoize
