module Frogurth.CSV( processCSV ) where 

import Data.Map( Map, fromList )
import Data.Maybe( fromJust )
import Data.List( elemIndex )
import Data.Either( Either(..), lefts, rights )

<<<<<<< HEAD
splitOn d s 
    | s == [] = []
    | otherwise = str : (splitOn d rest)
	where str = takeWhile (/=d) s
	      rest = drop ((length str) + 1) s

processCSV ls = let h = splitOn ',' $ head ls
=======
splitComma :: String -> [String]
splitComma "" = []
splitComma s = let str = takeWhile (/= ',') s
                   len = (length str) + 1
                   rest = drop len s
               in str : (splitComma rest)

processCSV :: [String] -> Either [String] [Map String String]
processCSV ls = let h = splitComma $ head ls
>>>>>>> 37130f27c82f5b92db32c8a75369b93148d32cfc
                    results = map (parseLine h (tail ls)) (tail ls)
                in if lefts results == []
                   then Right $ rights results
                   else Left $ lefts results

<<<<<<< HEAD
parseLine header ls line = let withKeys = fromList . zip header
                               splitLine = splitOn ',' line
=======

parseLine :: [String] -> [String] -> String -> Either String (Map String String)
parseLine header ls line = let mapping = fromList . zip header
                               splitLine = splitComma line
>>>>>>> 37130f27c82f5b92db32c8a75369b93148d32cfc
                               getIndex = show . (+2) $ fromJust $ elemIndex line ls
                           in if length header > length splitLine
                              then Left $ "to few values on line " ++ getIndex 
                              else if length header < length splitLine
                                   then Left $ "to many values on line " ++ getIndex  
                                   else Right $ withKeys splitLine
