{-
21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

43 44 45 46 47 48 49
42 21 22 23 24 25 26
41 20  7  8  9 10 27
40 19  6  1  2 11 28
39 18  5  4  3 12 29
38 17 16 15 14 13 30
37 36 35 34 33 32 31
-}

sumDiagonal :: Int -> Int
sumDiagonal 1 = 1
sumDiagonal dimension = offsetSum dimension + sumDiagonal (dimension-2)

offsetSum :: Int -> Int
offsetSum dimension =
  sum [offset + (dimension-1)*x | x <- [1..4]]
  where prevDim = dimension - 2
        offset = prevDim*prevDim

main = do
  putStrLn (show (sumDiagonal 1001))
