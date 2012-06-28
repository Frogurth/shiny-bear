module Artes.CSV(processCSV) where

import Data.Map(Map, fromList)

splitOn :: Char -> String -> [String]
splitOn _ "" = []
splitOn d s = let str = takeWhile (/= d) s
                  len = (length str) + 1
                  rest = drop len s
              in str : (splitOn d rest)

processCSV :: Char -> [String] -> [Map String String]
processCSV d ls = let splitKomma = splitOn d
                      h = splitKomma $ head ls
                      mapin = fromList . zip h
                  in map (mapin . splitKomma) (tail ls) 
