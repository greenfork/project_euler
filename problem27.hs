import Data.Numbers.Primes

formulae :: Int -> Int -> Int -> Int
formulae a b x = x*x + a*x + b

maxPrimes :: (Int -> Int) -> Int
maxPrimes f = maxPrimesH f 0
  where maxPrimesH f n
          | isPrime (f n) = maxPrimesH f (n+1)
          | otherwise = n

listAllMaxPrimes =
  [(maxPrimes (formulae a b), (a,b))| a <- [-999..999], b <- [0..1000]]

myMax' first@(n, (_,_)) second@(m, (_,_)) = if n > m then first else second
myMax l = foldr1 myMax' l

prod (_, (a,b)) = a * b

main = do
  let m = myMax listAllMaxPrimes
  putStrLn (show m)
  putStrLn (show (prod m))
