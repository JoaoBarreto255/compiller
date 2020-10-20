module Syntax where
    type Name = String
    
    data Expr 
        = Float Float
        | Integer Int
        | BinOp Op Expr Expr
        | Var Name
        | Call Name [Expr]
        | Function Name [Expr] Expr
        | Extern Name [Expr]
        deriving (Eq, Ord, Show)
    
    data Op
        = Add
        | Minus
        | Times
        | Divide
        | Equals
        | Difference
        deriving (Eq, Ord, Show)