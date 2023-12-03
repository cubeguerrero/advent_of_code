import Data.List

parseLine :: String -> [Int]
parseLine [] = []
parseLine ('o':'n':'e':xs) = 1:parseLine ('n':'e':xs)
parseLine ('t':'w':'o':xs) = 2:parseLine ('w':'o':xs)
parseLine ('t':'h':'r':'e':'e':xs) = 3:parseLine ('h':'r':'e':'e':xs)
parseLine ('f':'o':'u':'r':xs) = 4:parseLine ('o':'u':'r':xs)
parseLine ('f':'i':'v':'e':xs) = 5:parseLine ('i':'v':'e':xs)
parseLine ('s':'i':'x':xs) = 6:parseLine ('i':'x':xs)
parseLine ('s':'e':'v':'e':'n':xs) = 7:parseLine ('e':'v':'e':'n':xs)
parseLine ('e':'i':'g':'h':'t':xs) = 8:parseLine ('i':'g':'h':'t':xs)
parseLine ('n':'i':'n':'e':xs) = 9:parseLine ('i':'n':'e':xs)
parseLine (x:xs) =
  case x of
    '1' -> 1:parseLine xs
    '2' -> 2:parseLine xs
    '3' -> 3:parseLine xs
    '4' -> 4:parseLine xs
    '5' -> 5:parseLine xs
    '6' -> 6:parseLine xs
    '7' -> 7:parseLine xs
    '8' -> 8:parseLine xs
    '9' -> 9:parseLine xs
    _ -> parseLine xs

getFirstAndLastNum :: [Int] -> (Int, Int)
getFirstAndLastNum nums = (head nums, last nums)

turnToFullInt :: (Int, Int) -> Int
turnToFullInt (a, b) = a * 10 + b

partTwo :: String -> Int
partTwo contents = foldl (\acc line -> acc + (turnToFullInt . getFirstAndLastNum . parseLine) line)
                          0 $ lines contents

main = do
  contents <- getContents
  let answer = partTwo contents
  putStrLn $ "The answer is " ++ show answer
