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

PROGRAM: extern SYM '(' ARGLIST ')' NL PROGRAM { (Extern $2 $4) : $7 }
       | FNLIST             { $1 }

ARGLIST: SYM ',' ARGLIST { (Var $1):$3 }
       | SYM             { Var $1 }
       | {- Empty -}     { [] }

FNDECL: fn SYM '(' ARGLIST ')' '=' STMT { (Function $2 $4 $7) }

FNLIST: FNLIST NL FNDECL { $1: $3 }
      | FNDECL           { $1 }

STMT: STMT NL ASSIGNEXPR  { $1:$3 }
    | ASSIGNEXPR          { $1 }

ASSIGNEXPR: SYM '=' BOOLEXPR              { Assign $1 $3 }
          | BOOLEXPR    { $1 }

BOOLEXPR: CMPEXPR '==' CMPEXPR            { BinOp Equals $1 $3 }
        | CMPEXPR '!=' CMPEXPR            { BinOp Difference $1 $3 }
CMPEXPR: EXPR '>' EXPR             { BinOp Less $3 $1 }
       | EXPR '>=' EXPR            { BinOp LessEq $3 $1 }
       | EXPR '<' EXPR             { BinOp Less $1 $3 }
       | EXPR '<=' EXPR            { BinOp LessEq $1 $3 }
       | EXPR                      { $1 }

EXPR: ATOM '+' EXPR             { BinOp Add $1 $3 }
    | ATOM '-' EXPR             { BinOp Subtract $1 $3 }
    | ATOM '*' EXPR             { BinOp Times $1 $3 }
    | ATOM '/' EXPR             { BinOp Division $1 $3 }
    | ATOM                      { $1 }

ATOM: not EXPR                  { Not $2 }
    | '-' ATOM %prec NEG        { Negate $2 }
    | '(' EXPR ')'              { $2 }
    | SYM '(' PARAMLIST ')'     { Call $1 $3 }
    | INT                       { Integer $1 }
    | FLOAT                     { Float $1 }
    | SYM                       { Var $1 }
    | true                      { Integer 1 }
    | false                     { Integer 0 }

PARAMLIST: EXPR ',' PARAMLIST   { $1: $3 }
         | EXPR                 { $1 }
         | {- Empty -}          { [] }


{

parseError :: [Token] -> Except String a
parseError (l:ls) = throwError (show l)
parseError [] = throwError "Unexpected end of input"

parseExpr :: String -> Either String Expr
parseExpr input = runExcept $ do
  tokenStream <- scanTokens input
  expr tokenStream

parseTokens :: String -> Either String [Token]
parseTokens = runExcept . scanTokens
}
    