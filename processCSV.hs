module Frogurth.CSV( processCSV ) where 

import Data.Map( Map, fromList )
import Data.Maybe( fromJust )
import Data.List( elemIndex )
import Data.Either( Either(..), lefts, rights )

splitOn d s 
    | s == [] = []
    | otherwise = str : (splitOn d rest)
	where str = takeWhile (/=d) s
	      rest = drop ((length str) + 1) s

processCSV ls = let h = splitOn ',' $ head ls
                    results = map (parseLine h (tail ls)) (tail ls)
                in if lefts results == []
                   then Right $ rights results
                   else Left $ lefts results

parseLine header ls line = let withKeys = fromList . zip header
                               splitLine = splitOn ',' line
                               getIndex = show . (+2) $ fromJust $ elemIndex line ls
                           in if length header > length splitLine
                              then Left $ "to few values on line " ++ getIndex 
                              else if length header < length splitLine
                                   then Left $ "to many values on line " ++ getIndex  
                                   else Right $ withKeys splitLine
