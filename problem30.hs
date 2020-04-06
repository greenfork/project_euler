digits :: Int -> [Int]
digits n = digitsH n []
  where digitsH 0 l = l
        digitsH n l = digitsH (div n 10) (mod n 10 : l)

sumOfPowers' :: Int -> [Int] -> Int
sumOfPowers' power l = foldr (\x acc -> acc + x^power) 0 l

sumOfPowers :: Int -> Int -> Int
sumOfPowers power n = sumOfPowers' power (digits n)

powerLimit :: Int -> Int
powerLimit power = powerLimitH 9
  where powerLimitH n
          | n > sumOfPowers power n = n
          | otherwise = powerLimitH (n*10 + 9)

-- finite only
result power = [n | n <- [2..10000], n == (sumOfPowers power n)]

-- infinite
result2 power = result2H [2..] []
  where result2H (x:xs) rs
          | x > limit = rs
          | x == sumpow = result2H xs (x:rs)
          | otherwise = result2H xs rs
          where sumpow = sumOfPowers power x
        limit = powerLimit power

main = do
  putStrLn (show (sum (result2 5)))
