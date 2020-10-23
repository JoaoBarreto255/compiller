module Syntax where
    type Name = String
    
    data Expr 
        = Float Float
        | Integer Int
        | BinOp Op Expr Expr
        | Negate Expr
        | Not Expr
        | Var Name Type
        | Assign Name Expr
        | Call Name [Expr]
        | Function Name [Expr] Expr
        | Extern Name [Expr]
        deriving (Eq, Ord, Show)
    
    data Type 
        = Type String 
        | CallVar
        deriving (Eq, Ord, Show)
    
    data Op
        = Add
        | Subtract
        | Times
        | Division
        | Equals
        | Less
        | LessEq
        | Difference
        deriving (Eq, Ord, Show)
