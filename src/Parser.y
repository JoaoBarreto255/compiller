{
module Parser(
    parseExpr
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
    '+'     { TokenAdd }
	'-'     { TokenSub }
	'*'     { TokenMul }
	'/'     { TokenDiv }
	'='     { TokenEqual }
	'=='    { TokenEquals }
	'!='    { TokenDiff }
	'('     { TokenLParen }
	')'     { TokenRParen }
	'{'     { TokenLBrace }
	'}'     { TokenRBrace }
	'['     { TokenLBracket }
	']'     { TokenRBracket }
    ','     { TokenComma }
    '\n'    { TokenNewline }
    INT     { TokenInt $$ }
    FLOAT   { TokenFloat $$ }
    SYM     { TokenSymbol $$ }

%% 

PROGRAM: EXTERNSTMT PROGRAM { $1 : $2 }
       | FNLIST             { $1 }

EXTERNSTMT: extern SYM '(' ARGLIST ')' '\n' { Extern $2 $3 }

ARGLIST: SYM ',' ARGLIST { (Var $1):$3 }
       | SYM             { Var $1 }

FNLIST: FNSTMT FNLIST { $1 : $2 }
      | FNSTMT

FNSTMT: 'fn' SYM '(' ARGLIST ')' '=' FNBODY { Function $2 $4 $5 }

FNBODY