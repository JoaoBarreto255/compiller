{

module Parser(
    parseExpr,
    parseTokens
) where
    import Lexer
    import Sytax

    import Control.Monad.Except
}
-- Lexer Structure
%tokentype  { Token }
%monad {Except String} { >>= } { return }
%error { parseError }

%name expr

-- Token Names
%token 
    fn      { TokenFn }
    false   { TokenFalse }
    true    { TokenTrue }
    extern  { TokenExtern }
    not     { TokenNot}
    '+'     { TokenAdd }
	'-'     { TokenSub }
	'*'     { TokenMul }
	'/'     { TokenDiv }
	'='     { TokenEqual }
	'=='    { TokenEquals }
    '!='    { TokenDiff }
    '>'     { TokenGt }
    '>='    { TokenGtEq }
    '<'     { TokenLess }
    '<='    { TokenLessEq }
	'('     { TokenLParen }
	')'     { TokenRParen }
	'{'     { TokenLBrace }
	'}'     { TokenRBrace }
	'['     { TokenLBracket }
	']'     { TokenRBracket }
    ','     { TokenComma }
    NL    { TokenNewline }
    INT     { TokenInt $$ }
    FLOAT   { TokenFloat $$ }
    SYM     { TokenSymbol $$ }


-- declare associative
%right '='
%nonassoc '==' '!='
%nonassoc '>' '<' '>=' '<='
%left '+' '-'
%left '*' '/'
%left NEG 
%% 

PROGRAM: extern FNHEAD NL PROGRAM   { let (name, args) = $2 in (Extern name args) : $4 }
       | FNLIST                     { $1 }

FNLIST: FNLIST FNDECL            { $1: $2 }
      | FNDECL                      { [$1] }

FNDECL: fn FNHEAD '=' STMT          { let (name, args) = $2 in Function name args $4 }

FNHEAD: SYM '(' ARGLIST ')'         { ($1, $3) }

ARGLIST: SYM SYM ',' ARGLIST        { (Var $2 (Type $1)):$4 }
       | SYM SYM                    { [Var $2 (Type $1)] }
       | {- Empty -}                { [] }

STMT: ASSIGNEXPR NL STMT            { $1:$3 }
    | ASSIGNEXPR NL                 { [$1] }
    | ASSIGNEXPR                    { [$1] }

ASSIGNEXPR: SYM '=' BOOLEXPR        { Assign $1 $3 }
          | BOOLEXPR                { $1 }

BOOLEXPR: CMPEXPR '==' CMPEXPR      { BinOp Equals $1 $3 }
        | CMPEXPR '!=' CMPEXPR      { BinOp Difference $1 $3 }
        | not BOOLEXPR              { Not $2 }
        | true                      { Integer 1 }
        | false                     { Integer 0 }
        | CMPEXPR                   { $1 }

CMPEXPR: EXPR '>' EXPR              { BinOp Less $3 $1 }
       | EXPR '>=' EXPR             { BinOp LessEq $3 $1 }
       | EXPR '<' EXPR              { BinOp Less $1 $3 }
       | EXPR '<=' EXPR             { BinOp LessEq $1 $3 }
       | EXPR                       { $1 }

EXPR: EXPR '+' EXPR                 { BinOp Add $1 $3 }
    | EXPR '-' EXPR                 { BinOp Subtract $1 $3 }
    | EXPR '*' EXPR                 { BinOp Times $1 $3 }
    | EXPR '/' EXPR                 { BinOp Division $1 $3 }
    | '-' EXPR %prec NEG            { Negate $2 }
    | ATOM                          { $1 }

ATOM: '(' BOOLEXPR ')'              { $2 }
    | SYM '(' PARAMLIST ')'         { Call $1 $3 }
    | INT                           { Integer $1 }
    | FLOAT                         { Float $1 }
    | SYM                           { Var $1 CallVar }

PARAMLIST: PARAMLIST ',' BOOLEXPR   { $1: $3 }
         | BOOLEXPR                 { [$1] }
         | {- Empty -}              { [] }


{

parseError :: [Token] -> Except String a
parseError (l:ls) = throwError (show l)
parseError [] = throwError "Unexpected end of input"

parseExpr :: String -> Either String [Expr]
parseExpr input = runExcept $ do
  tokenStream <- scanTokens input
  expr tokenStream

parseTokens :: String -> Either String [Token]
parseTokens = runExcept . scanTokens
}
    