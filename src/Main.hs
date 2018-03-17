module Main where
import System.Environment
import System.Directory
import System.IO
import System.Process


import AppModules




import qualified Data.List as DL

fileName :: FilePath
fileName = "/home/henry/HENFILES/.webLinks"

main :: IO ()
main = do

    fileExist <- doesFileExist fileName
    if (not fileExist)
    then writeFile fileName ""
    else return ()
    
    inputArgs <- getArgs

    argRun inputArgs
    where argRun args
            | args == [] = list []
            | isInteger (head args) = open [head args] 
            | otherwise =  do (cmd:arguments) <- getArgs
                              
                              ----------------------------------                              
                              let runLookup chosenCommand = 
                                           case chosenCommand of
                                               Just realCommand -> realCommand arguments
                                               Nothing -> putStrLn ("Command \"" ++ cmd ++ "\" not found") >> help []
                              ---------------------------------
                              
                              runLookup (lookup cmd dispatch) --Run maybe lookup


add [address] = appendFile fileName (address ++ "\n")

open [line] = do
    contents <- readFile fileName
    let lnLink = (lines contents) !! (read line :: Int)
    r <- createProcess (shell ("(xdg-open "++lnLink ++ ") &>/dev/null") )
    putStrLn ("opened "++ lnLink)

deleteAt :: Int -> [a] -> [a]
deleteAt 0 (x:xs) = xs
deleteAt n (x:xs) | n >= 0 = x : (deleteAt (n-1) xs)
deleteAt _ _ = error "index out of range"

remove [line] = do
    contents <- readFile (fileName)
    writeFile "temp" (unlines $ deleteAt (read line :: Int) (lines contents))
    removeFile fileName
    renameFile "temp" fileName

list [] = do
    contents <- readFile fileName 
    putStrLn $ addLnNums contents

dispatch =  [ ("list",list)
            , ("add",add)
            , ("open",open)
            , ("remove",remove)
            , ("help", help)
            ]
help [] = do putStr $ unlines [""
                              ,"LinkKeeper (lnkp) Command help"
                              ,"----------(Commands)----------"
                              ,"help                  | shows this page"
                              ,"list                  | Lists stored links"
                              ,"add (link text)       | adds link to list"
                              ,"open (link number)    | opens link by number"
                              ,"remove (link number)  | removes link by number"
                              ,"-----------------------------"
                              ,""]
            


addLnNums list = unlines $ zipWith (\n a -> "<"++(show n)++"> "++ a) [0..] (lines list)


isInteger s = case reads s :: [(Integer, String)] of
  [(_, "")] -> True
  _         -> False
