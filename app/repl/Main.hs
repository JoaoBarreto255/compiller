module Main where
import Syntax
import Parser
import CompilerError
import System.IO
import Control.Monad.Except

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
processLine line = do 
    -- processLineResult $ parseTokens line
    processLineResult line $ parseExpr line 

    where 
        formatText:: String -> String
        formatText str = "\n=>   " ++ str ++ "\n"

        processLineResult :: Show a => String -> Either CompilerError a -> IO ()
        processLineResult line result = putStrLn $ do
            case result of
                Right succ -> formatText $ show succ
                Left error -> formatText $ showInputError line (pos error) ++ msg error


promptLine:: String -> IO String
promptLine header = do
    putStr header 
    hFlush stdout
    getLine

        