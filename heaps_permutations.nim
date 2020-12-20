iterator HeapsPermutations*(s: string): string =
  ## `s` must be lexicographically weakly ordered.
  let n = s.len
  var
    stack: seq[int]
    stackPointer = 0
    s = s
  for i in 0..<n: stack.add 0
  yield s
  while stackPointer < n:
    if stack[stackPointer] < stackPointer:
      if stackPointer mod 2 == 0:
        swap(s[0], s[stackPointer])
      else:
        swap(s[stack[stackPointer]], s[stackPointer])
      yield s
      stack[stackPointer] += 1
      stackPointer = 0
    else:
      stack[stackPointer] = 0
      stackPointer += 1
