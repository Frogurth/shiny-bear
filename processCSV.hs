module Frogurth.CSV( processCSV ) where

import Data.Map( Map, fromList )
import Data.Maybe( fromJust )
import Data.List( elemIndex )
import Data.Either( Either(..), lefts, rights )

splitComma :: String -> [String]
splitComma "" = []
splitComma s = let str = takeWhile (/= ',') s
                   len = (length str) + 1
                   rest = drop len s
               in str : (splitComma rest)

processCSV :: [String] -> Either [String] [Map String String]
processCSV ls = let h = splitComma $ head ls
                    results = map (parseLine h (tail ls)) (tail ls)
                in if lefts results == []
                   then Right $ rights results
                   else Left $ lefts results


parseLine :: [String] -> [String] -> String -> Either String (Map String String)
parseLine header ls line = let mapping = fromList . zip header
                               splitLine = splitComma line
                               getIndex = show . (+2) $ fromJust $ elemIndex line ls
                           in if length header > length splitLine
                              then Left $ "to few values on line " ++ getIndex 
                              else if length header < length splitLine
                                   then Left $ "to many values on line " ++ getIndex  
                                   else Right $ mapping splitLine
