#  d
#
#     a
#
#   c   b   e
#
# f

# Should have same sum total:
# dab; ebc; fca

# First solve for 3-gon

from algorithm import sorted
from strutils import parseInt, join

func anyEqual(x: openArray[SomeNumber]): bool =
  for i in 0..<(x.len - 1):
    for k in (i+1)..<x.len:
      if x[i] == x[k]: return true

func `<`(a, b: openArray[SomeNumber]): bool =
  a.join.parseInt < b.join.parseInt

proc solve3gon =
  var maximum: array[9, int]
  for total in 9..12:
    var answers: seq[array[9, int]]
    for a in 1..6:
      for b in 1..6:
        if anyEqual([a, b]): continue
        for c in 1..6:
          if anyEqual([a, b, c]): continue
          for d in 1..6:
            if anyEqual([a, b, c, d]): continue
            for e in 1..6:
              if anyEqual([a, b, c, d, e]): continue
              for f in 1..6:
                if anyEqual([a, b, c, d, e, f]): continue
                if d+a+b == total and e+b+c == total and f+c+a == total:
                  if [a,b,c,d,e,f].sorted != [1,2,3,4,5,6]: assert false
                  let min = min([d, e, f])
                  let sequence =
                    if min == d:
                      [d,a,b, e,b,c, f,c,a]
                    elif min == e:
                      [e,b,c, f,c,a, d,a,b]
                    elif min == f:
                      [f,c,a, d,a,b, e,b,c]
                    else:
                      [0,0,0,0,0,0,0,0,0]
                  if sequence notin answers:
                    answers.add sequence
    for answer in answers:
      echo total, ": ", answer
      if answer > maximum: maximum = answer
  echo "max: ", maximum.join

# solve3gon()

#     g
#      \
#        b     h
#      /   \  /
#    a       c
#   / \     /
#  /   e---d----i
# f     \
#        \
#         j

# Should have same sum total:
# gbc; hcd; ide; jea; fab

proc solve5gon =
  var maximum: array[15, int]
  for total in 13..20:
    # echo "total: ", total
    var answers: seq[array[15, int]]
    for a in 1..10:
      for b in 1..10:
        if b == a: continue
        for c in 1..10:
          if c == a or c == b: continue
          for d in 1..10:
            if d == a or d == b or d == c: continue
            for e in 1..10:
              if e == a or e == b or e == c or e == d: continue
              for f in 1..10:
                if f == a or f == b or f == c or f == d or f == e: continue
                for g in 1..10:
                  if g == a or g == b or g == c or g == d or g == e or
                     g == f: continue
                  for h in 1..10:
                    if h == a or h == b or h == c or h == d or h == e or
                       h == f or h == g: continue
                    for i in 1..10:
                      if i == a or i == b or i == c or i == d or i == e or
                         i == f or i == g or i == h: continue
                      for j in 1..10:
                        if j == a or j == b or j == c or j == d or j == e or
                           j == f or j == g or j == h or j == i: continue
                        if g+b+c == total and h+c+d == total and
                           i+d+e == total and j+e+a == total and
                           f+a+b == total:
                          if [a,b,c,d,e,f,g,h,i,j].sorted !=
                             [1,2,3,4,5,6,7,8,9,10]:
                            echo [a,b,c,d,e,f,g,h,i,j]
                            assert false
                          let min = min([f, g, h, i, j])
                          let sequence =
                            if min == f:
                              [f,a,b, g,b,c, h,c,d, i,d,e, j,e,a]
                            elif min == g:
                              [g,b,c, h,c,d, i,d,e, j,e,a, f,a,b]
                            elif min == h:
                              [h,c,d, i,d,e, j,e,a, f,a,b, g,b,c]
                            elif min == i:
                              [i,d,e, j,e,a, f,a,b, g,b,c, h,c,d]
                            elif min == j:
                              [j,e,a, f,a,b, g,b,c, h,c,d, i,d,e]
                            else:
                              [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                          if sequence notin answers:
                            answers.add sequence
    for answer in answers:
      echo total, ": ", answer
      if answer > maximum and answer.join.len == 16: maximum = answer
  echo "max 16-digit string: ", maximum.join

solve5gon()
