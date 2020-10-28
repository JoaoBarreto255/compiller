module Repl where
import Syntax
import Parser

main :: IO ()
main = do 
     putStrLn "Kaleidoscope Lang Repl"
     processInput

processInput :: IO ()
processInput = do 
             putStr ">>> "
             line <- getLine
             putStrLn $ case parseExpr line of
                Right expr -> show expr
                Left error -> error
             processInput

        