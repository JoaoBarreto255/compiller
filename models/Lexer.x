{
module Lexer(Token(..), scanTokens, showTokenError, getTokenPosition) where
import Syntax
import Control.Monad.Except
import CompilerError
}

%wrapper "posn"

$digit = [0-9]
$hexaDigit = [0-9a-fA-F]
$alpha = [a-zA-Z]

tokens :- 

	-- Content Ignore
	$white+		;
	
	"#".*  		; -- line coments
	"/*".*"*/"	; -- multiline coments

	-- Syntax 
	fn 							                       { \pos s -> TokenFn (transformPosition pos s) }
	true						                       { \pos s -> TokenTrue (transformPosition pos s) }
	false						                       { \pos s -> TokenFalse (transformPosition pos s) }
	extern						                       { \pos s -> TokenExtern (transformPosition pos s) }
	\+							                       { \pos s -> TokenAdd (transformPosition pos s) }
	\-							                       { \pos s -> TokenSub (transformPosition pos s) }
	\/							                       { \pos s -> TokenDiv (transformPosition pos s) }
	\*							                       { \pos s -> TokenMul (transformPosition pos s) }
	\=							                       { \pos s -> TokenEqual (transformPosition pos s) }
	\=\=						                       { \pos s -> TokenEquals (transformPosition pos s) }
    \!\=						                       { \pos s -> TokenDiff (transformPosition pos s) }
    \>                                                 { \pos s -> TokenGt (transformPosition pos s) }
    \>\=                                               { \pos s -> TokenGtEq (transformPosition pos s) }
    \<                                                 { \pos s -> TokenLess (transformPosition pos s) }
    \<\=                                               { \pos s -> TokenLessEq (transformPosition pos s) }
    ($digit+|[0] [xX] $hexaDigit+)                     { \pos s -> TokenInt s (transformPosition pos s) }
	$alpha [$alpha $digit \_]*	                       { \pos s -> TokenSymbol s (transformPosition pos s) }
    $digit+ (\. $digit+([eE] \-? $digit+)?)?           { \pos s -> TokenFloat s (transformPosition pos s) }
	\(							                       { \pos s -> TokenLParen (transformPosition pos s) }
	\)							                       { \pos s -> TokenRParen (transformPosition pos s) }
	\{							                       { \pos s -> TokenLBrace (transformPosition pos s) }
	\}							                       { \pos s -> TokenRBrace (transformPosition pos s) }
	\[							                       { \pos s -> TokenLBracket (transformPosition pos s) }
	\]							                       { \pos s -> TokenRBracket (transformPosition pos s) }
	\r?\n 					                           { \pos s -> TokenNewline (transformPosition pos s) }
	\, 							                       { \pos s -> TokenComma (transformPosition pos s) }
    not                                                { \pos s -> TokenNot (transformPosition pos s) }

{
data Token 
    = TokenFn Position
    | TokenFalse Position
    | TokenTrue Position
    | TokenExtern Position
    | TokenAdd Position
    | TokenSub Position
    | TokenMul Position
    | TokenDiv Position
    | TokenEqual Position
    | TokenEquals Position
    | TokenDiff Position
    | TokenGt Position
    | TokenGtEq Position
    | TokenLess Position
    | TokenLessEq Position
    | TokenNot Position
    | TokenSymbol String Position
    | TokenInt String Position
    | TokenFloat String Position
    | TokenLParen Position
    | TokenRParen Position
    | TokenLBrace Position
    | TokenRBrace Position
    | TokenLBracket Position
    | TokenRBracket Position
    | TokenEOF Position
    | TokenNewline Position
    | TokenComma Position
    deriving (Eq, Show)

scanTokens :: String -> Except CompilerError [Token]
scanTokens str = go (alexStartPos, '\n', [], str) []
        where 
            go:: (AlexPosn, Char, [Byte], String) -> [Token] -> Except CompilerError [Token]
            go inp@(pos, _, _, str) tokens = case alexScan inp 0 of 
                AlexEOF -> return tokens
                AlexError (epos, _, _, tmp) -> throwError $ let newPos = transformPosition epos "" in Message { 
                    msg = ("lexical error " ++ show (head tmp) ++ " in file at " ++ show (line newPos) ++ " line, " ++ show (col newPos) ++ " column"), 
                    pos = newPos }
                AlexSkip newInput len -> go newInput tokens
                AlexToken newInput len act -> go newInput ((act pos (take len str)):tokens)

showTokenError :: Token -> String
showTokenError (TokenFn pos) = showToken "fn" pos
showTokenError (TokenFalse pos) = showToken "false" pos
showTokenError (TokenTrue pos) = showToken "true" pos
showTokenError (TokenExtern pos) = showToken "extern" pos
showTokenError (TokenNot pos) = showToken "not" pos
showTokenError (TokenAdd pos) = showToken "+" pos
showTokenError (TokenSub pos) = showToken "-" pos
showTokenError (TokenMul pos) = showToken "*" pos
showTokenError (TokenDiv pos) = showToken "/" pos
showTokenError (TokenEqual pos) = showToken "=" pos
showTokenError (TokenEquals pos) = showToken "==" pos
showTokenError (TokenDiff pos) = showToken "!=" pos
showTokenError (TokenGt pos) = showToken ">" pos
showTokenError (TokenGtEq pos) = showToken ">=" pos
showTokenError (TokenLess pos) = showToken "<" pos
showTokenError (TokenLessEq pos) = showToken "<=" pos
showTokenError (TokenLParen pos) = showToken "(" pos
showTokenError (TokenRParen pos) = showToken ")" pos
showTokenError (TokenLBrace pos) = showToken "{" pos
showTokenError (TokenRBrace pos) = showToken "}" pos
showTokenError (TokenLBracket pos) = showToken "[" pos
showTokenError (TokenRBracket pos) = showToken "]" pos
showTokenError (TokenComma pos) = showToken "," pos
showTokenError (TokenNewline pos) = showToken "\\n" pos
showTokenError (TokenInt val pos) = showToken (show val) pos
showTokenError (TokenFloat val pos) = showToken (show val) pos
showTokenError (TokenSymbol val pos) = showToken val pos

showToken :: String -> Position -> String
showToken tokenName Nil = show tokenName
showToken tokenName pos = show tokenName ++ " at line " ++ show (line pos) ++ " and column "++ show (col pos) ++ "."

transformPosition :: AlexPosn -> String -> Position
transformPosition (AlexPn cp l c) tkStr = Pos { charPos = cp, line = l, col = c, len = length tkStr }

getTokenPosition :: Token -> Position
getTokenPosition (TokenFn pos)          = pos
getTokenPosition (TokenFalse pos)       = pos
getTokenPosition (TokenTrue pos)        = pos
getTokenPosition (TokenExtern pos)      = pos
getTokenPosition (TokenNot pos)         = pos
getTokenPosition (TokenAdd pos)         = pos
getTokenPosition (TokenSub pos)         = pos
getTokenPosition (TokenMul pos)         = pos
getTokenPosition (TokenDiv pos)         = pos
getTokenPosition (TokenEqual pos)       = pos
getTokenPosition (TokenEquals pos)      = pos
getTokenPosition (TokenDiff pos)        = pos
getTokenPosition (TokenGt pos)          = pos
getTokenPosition (TokenGtEq pos)        = pos
getTokenPosition (TokenLess pos)        = pos
getTokenPosition (TokenLessEq pos)      = pos
getTokenPosition (TokenLParen pos)      = pos
getTokenPosition (TokenRParen pos)      = pos
getTokenPosition (TokenLBrace pos)      = pos
getTokenPosition (TokenRBrace pos)      = pos
getTokenPosition (TokenLBracket pos)    = pos
getTokenPosition (TokenRBracket pos)    = pos
getTokenPosition (TokenComma pos)       = pos
getTokenPosition (TokenNewline pos)     = pos
getTokenPosition (TokenInt _ pos)       = pos
getTokenPosition (TokenFloat _ pos)     = pos
getTokenPosition (TokenSymbol _ pos)    = pos
}