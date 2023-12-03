import Data.Char
import Data.List

parseLine :: String -> [Int]
parseLine = reverse . foldl (\acc c -> if isDigit c then (read [c] :: Int):acc else acc) []

getFirstAndLastNum :: [Int] -> (Int, Int)
getFirstAndLastNum nums = (head nums, last nums)

turnToFullInt :: (Int, Int) -> Int
turnToFullInt (a, b) = a * 10 + b

partOne :: String -> Int
partOne contents = foldl (\acc line -> acc + (turnToFullInt . getFirstAndLastNum . parseLine) line)
                          0 $ lines contents

main = do
  contents <- getContents
  let answer = partOne contents
  putStrLn $ "The total is " ++ show answer
