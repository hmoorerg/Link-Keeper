module Main where
import System.Environment
import System.Directory
import System.IO
import qualified Data.List as DL

main :: IO ()
main = do
  (cmd:args) <- getArgs
  putStrLn (cmd ++ ":" ++ args)
