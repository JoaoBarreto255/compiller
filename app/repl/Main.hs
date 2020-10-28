module Main where
import Syntax
import Parser
import System.IO

main :: IO ()
main = do 
    putStrLn "Kaleidoscope Lang Repl\n"
    processInput

processInput :: IO ()
processInput = do 
    line <- promptLine ">>> "
    if ":exit" /= line then
        processLine line >> processInput
    else
        putStrLn "\n\nBye! :-)"

processLine:: String -> IO ()
processLine line = putStrLn $ case parseExpr line of
        Right expr -> formatText $ show expr
        Left error -> formatText error
    where formatText str = "\n=>   " ++ str ++ "\n"

promptLine:: String -> IO String
promptLine header = do
    putStr header 
    hFlush stdout
    getLine

        