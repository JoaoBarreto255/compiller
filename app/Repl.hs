module Repl where
import Syntax
import Parser

main :: IO ()
main = do 
     putStrLn "Kaleidoscope Lang Repl"
     processInput

processInput :: IO ()
processInput = do 
             putStr ">>>"
             line <- getLine
             result <- parseExpr line
             putStrLn $ case result of
                (x:xs) -> show (x:xs)
                error  -> error
             processInput

        