import System.Environment( getArgs )
import Artes.CSV

main = do
  args <- getArgs
  interactFile (show . processCSV (',') . lines) (head args)
  
interactFile f fileName = do 
  s <- readFile fileName
  putStrLn (f s)
