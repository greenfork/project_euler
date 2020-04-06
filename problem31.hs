import Data.Function.Memoize

twoPounds = 200
onePound = 100
fiftyPences = 50
twentyPences = 20
tenPences = 10
fivePences = 5
twoPences = 2
onePence = 1

maxSum = 200

limitRange pences = [0..div maxSum pences]

sumOfCoins :: [Int] -> Int
sumOfCoins [a, b, c, d, e, f, g] =
  a*twoPounds +
  b*onePound +
  c*fiftyPences +
  d*twentyPences +
  e*tenPences +
  f*fivePences +
  g*twoPences

-- one pence is complementary to any sum less or equal than 200
allPermutations = [[a, b, c, d, e, f, g] |
    a <- limitRange twoPounds,
    b <- limitRange onePound,
    c <- limitRange fiftyPences,
    d <- limitRange twentyPences,
    e <- limitRange tenPences,
    f <- limitRange fivePences,
    g <- limitRange twoPences,
    sumOfCoins [a, b, c, d, e, f, g] <= 200
  ]

-- leAttempteSecundo
nextLargestCoin 200 = 100
nextLargestCoin 100 = 50
nextLargestCoin 50 = 20
nextLargestCoin 20 = 10
nextLargestCoin 10 = 5
nextLargestCoin 5 = 2
nextLargestCoin 2 = 1

f :: Int -> Int -> Int
f target largestCoin
  | target == 0 || largestCoin == 1 = 1
  | otherwise =
    sum [f (target - i*largestCoin) (nextLargestCoin largestCoin) |
        i <- [0..div target largestCoin]
      ]
fmem = memoize f
