module Frogurth.CSV( processCSV ) where

import Data.Map( Map, fromList )
import Data.Maybe( fromJust )
import Data.List( elemIndex )
import Data.Either( Either(..), lefts, rights )

splitKomma :: String -> [String]
splitKomma "" = []
splitKomma s = let str = takeWhile (/= ',') s
                   len = (length str) + 1
                   rest = drop len s
               in str : (splitKomma rest)

processCSV :: Char -> [String] -> Either [String] [Map String String]
processCSV d ls = let h = splitKomma $ head ls
                      results = map (parseLine h (tail ls)) (tail ls)
                  in if lefts results == []
                     then Right $ rights results
                     else Left $ lefts results


parseLine :: [String] -> [String] -> String -> Either String (Map String String)
parseLine header ls line = let mapping = fromList . zip header
                               splitLine = splitKomma line
                               getIndex = show . (+2) $ fromJust $ elemIndex line ls
                           in if length header > length splitLine
                              then Left $ "to few values on line " ++ getIndex 
                              else if length header < length splitLine
                                   then Left $ "to many values on line " ++ getIndex  
                                   else Right $ mapping splitLine
