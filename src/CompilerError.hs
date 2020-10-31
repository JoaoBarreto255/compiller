module CompilerError (CompilerError(..), Position(..), createEOFPosition) where

    data CompilerError 
        = Message { msg::String, pos::Position }
        deriving (Eq, Show)
    
    data Position
        = Nil
        | Pos { charPos::Int, line::Int, col::Int, len::Int }
        deriving (Eq, Show)
    
    createEOFPosition :: String -> Position
    createEOFPosition "" = Nil
    createEOFPosition input = process input 0 1 1
        where process :: String -> Int -> Int -> Int -> Position
              process "" curPos li column = Pos { charPos = curPos, line = li, col = column, len = 1}
              process (c:chars) cp l cl = if '\n' == c then process chars (cp+1) (l+1) 1
                                          else process chars (cp+1) l (cl+1)
    
    showInputError :: String -> Position -> String
    showInputError "" _ = "Empty Input"
    showInputError str Nil = showInputError str $ createEOFPosition str
    showInputError str pos = result ++ posArrow
        where posArrow = replicate (4 + col pos) ' ' ++ replicate (len pos) '^'
              result = addSpace $ revRev $ processInput str pos (0, 1, 1, [[]])

              addSpace [x]    = ">   " ++ x
              addSpace (x:xs) = "    " ++ x ++ addSpace xs
              
              revRev :: [String] -> [String]
              revRev [] = []
              revRev (x:xs) = revRev xs ++ [reverse x]
              
              appendSlashN :: String -> String
              appendSlashN [] = "\n"
              appendSlashN (x:xs) | x == '\n' = x:xs
                                  | otherwise = '\n':x:xs

              processInput :: String -> Position -> (Int, Int, Int, [String]) -> [String]
              processInput [] pos (_,_,_,stack) = take 6 stack
                    where h = appendSlashN $ head stack
                          t = take 5 $ tail stack
                          
              processInput (c:chars) pos (cp, l, cl, lineStack) 
                    | charPos pos == cp = takeEndLine (c:chars) currentLine : fiveTopLines
                    | c == '\n' = processInput chars pos (cp+1, l+1, 0, []:(c:currentLine):fiveTopLines)
                    | otherwise = processInput chars pos (cp+1, l, cl+1, (c:currentLine):fiveTopLines)
                    where 
                        currentLine = head lineStack
                        fiveTopLines = take 5 $ tail lineStack
                        takeEndLine [] cline = appendSlashN cline
                        takeEndLine (x:xs) cline
                            | x == '\n' = x:cline
                            | otherwise = x:takeEndLine xs cline
                        


    