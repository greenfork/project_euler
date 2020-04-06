import Data.List

listOfPowers = [a^b | a <- [2..100], b <- [2..100]]

main = do
  putStrLn (show (length (nub listOfPowers)))
