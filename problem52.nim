from algorithm import sort

for n in 1..1_000_000:
  let
    n2 = n*2
    n3 = n*3
    n4 = n*4
    n5 = n*5
    n6 = n*6
  var
    s1 = $n
    s2 = $n2
    s3 = $n3
    s4 = $n4
    s5 = $n5
    s6 = $n6
  if s1.len == s6.len:
    s1.sort
    s2.sort
    s3.sort
    s4.sort
    s5.sort
    s6.sort
    if s1 == s2 and s1 == s3 and s1 == s4 and s1 == s5 and s1 == s6:
      echo n, ", ", n2, ", ", n3, ", ", n4, ", ", n5, ", ", n6
      break
