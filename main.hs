import System.Environment( getArgs )
import qualified Data.Map
import Frogurth.CSV

main = do
  args <- getArgs
  interactFile (show . processCSV . lines) (head args)
  
interactFile f fileName = do 
  s <- readFile fileName
  putStrLn (f s)
