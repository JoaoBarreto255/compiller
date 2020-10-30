module CompilerError (CompilerError(..), Position(..), createEOFPosition) where

    data CompilerError 
        = Message { msg::String, pos::Position }
        deriving (Eq, Show)
    
    data Position
        = Nil
        | Pos { charPos::Int, line::Int, col::Int }
        deriving (Eq, Show)
    
    createEOFPosition :: String -> Position
    createEOFPosition "" = Nil
    createEOFPosition input = process input 0 1 1
        where process :: String -> Int -> Int -> Int -> Position
              process "" curPos li column = Pos { charPos = curPos, line = li, col = column}
              process (c:chars) cp l cl = if '\n' == c then process chars (cp+1) (l+1) 1
                                          else process chars (cp+1) l (cl+1)    
    