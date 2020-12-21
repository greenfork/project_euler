from strutils import replace, parseInt
from eratosthenes import primesArray

proc replaceAndFindPrimes(s: string): seq[int] =
  for ch in '0'..'9':
    let str = s.replace('x', ch)
    if str[0] == '0': continue
    let number = parseInt(str)
    if primesArray[number] == true:
      result.add number

for i in 10..<primesArray.len:
  if primesArray[i] == true:
    let str = $i
    for k in 0..<str.len:
      var strWithX = str
      strWithX[k] = 'x'
      # let similarPrimes = replaceAndFindPrimes(strWithX)
      # if similarPrimes.len > 7:
      #   echo similarPrimes
      for p in 0..<str.len:
        if p == k: continue
        var strWithX = strWithX
        strWithX[p] = 'x'
        # let similarPrimes = replaceAndFindPrimes(strWithX)
        # if similarPrimes.len > 7:
        #   echo similarPrimes
        for m in 0..<str.len:
          if m == k or m == p: continue
          var strWithX = strWithX
          strWithX[m] = 'x'
          let similarPrimes = replaceAndFindPrimes(strWithX)
          if similarPrimes.len > 7:
            echo similarPrimes
