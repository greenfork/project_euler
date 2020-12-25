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

iterator HeapsPermutations*[S: auto, T: openArray[S]](ss: T): seq[S] =
  let n = ss.len
  var
    stack: seq[int]
    stackPointer = 0
    ss = @ss
  for i in 0..<n: stack.add 0
  yield ss
  while stackPointer < n:
    if stack[stackPointer] < stackPointer:
      if stackPointer mod 2 == 0:
        swap(ss[0], ss[stackPointer])
      else:
        swap(ss[stack[stackPointer]], ss[stackPointer])
      yield ss
      stack[stackPointer] += 1
      stackPointer = 0
    else:
      stack[stackPointer] = 0
      stackPointer += 1
