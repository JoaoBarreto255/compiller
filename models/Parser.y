{

module Parser(
  parseExpr,
  parseTokens
) where
import Lexer
import Syntax

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

PROGRAM:: { Expr }
PROGRAM: extern FNHEAD NL PROGRAM   { let Program (x:xs) fns = $4 in Program ($2:x:xs) fns }
       | FNLIST                     { $1 }

FNLIST:: { Expr }
FNLIST: FNDECL FNLIST               { let Program _ (x:xs) = $2 in Program [] ($1:xs) }
      | FNDECL                      { Program [] [$1] }

FNDECL:: { Expr }
FNDECL: fn FNHEAD '=' STMT          { let Extern name args = $2 in Function name args $4 }

FNHEAD:: { Expr }
FNHEAD: SYM '(' ARGLIST ')'         { Extern $1 $3 }

ARGLIST:: { [Expr] }
ARGLIST: SYM SYM ',' ARGLIST        { let (x:xs) = $4 in (Var $2 (Type $1)):x:xs }
       | SYM SYM                    { [Var $2 (Type $1)] }
       | {- Empty -}                { [] }

STMT:: { Expr }
STMT: ASSIGNEXPR NL STMT            { let Body (x:xs) = $3 in Body ($1:x:xs) }
    | ASSIGNEXPR NL                 { Body [$1] }
    | ASSIGNEXPR                    { Body [$1] }

ASSIGNEXPR:: { Expr }
ASSIGNEXPR: SYM '=' BOOLEXPR        { Assign $1 $3 }
          | BOOLEXPR                { $1 }

BOOLEXPR:: { Expr }
BOOLEXPR: CMPEXPR '==' CMPEXPR      { BinOp Equals $1 $3 }
        | CMPEXPR '!=' CMPEXPR      { BinOp Difference $1 $3 }
        | not BOOLEXPR              { Not $2 }
        | true                      { Integer 1 }
        | false                     { Integer 0 }
        | CMPEXPR                   { $1 }

CMPEXPR:: { Expr }
CMPEXPR: EXPR '>' EXPR              { BinOp Less $3 $1 }
       | EXPR '>=' EXPR             { BinOp LessEq $3 $1 }
       | EXPR '<' EXPR              { BinOp Less $1 $3 }
       | EXPR '<=' EXPR             { BinOp LessEq $1 $3 }
       | EXPR                       { $1 }

EXPR:: { Expr }
EXPR: EXPR '+' EXPR                 { BinOp Add $1 $3 }
    | EXPR '-' EXPR                 { BinOp Subtract $1 $3 }
    | EXPR '*' EXPR                 { BinOp Times $1 $3 }
    | EXPR '/' EXPR                 { BinOp Division $1 $3 }
    | '-' EXPR %prec NEG            { Negate $2 }
    | ATOM                          { $1 }

ATOM:: { Expr }
ATOM: '(' BOOLEXPR ')'              { $2 }
    | SYM '(' PARAMLIST ')'         { Call $1 $3 }
    | INT                           { Integer $1 }
    | FLOAT                         { Float $1 }
    | SYM                           { Var $1 CallVar }

PARAMLIST:: { [Expr] }
PARAMLIST: BOOLEXPR ',' PARAMLIST   { let (x:xs) = $3 in ($1:x:xs) }
         | BOOLEXPR                 { [$1] }
         | {- Empty -}              { [] }


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
    