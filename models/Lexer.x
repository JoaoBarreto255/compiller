{
module Lexer(Token(..), AlexPosn, scanTokens) where
import Syntax
import Control.Monad.Except
}

%wrapper "posn"

$digit = [0-9]
$hexaDigit = [0-9A-F]
$alpha = [a-zA-Z]

tokens :- 

	-- Content Ignore
	$white+		;
	
	"#".*  		; -- line coments
	"/*".*"*/"	; -- multiline coments

	-- Syntax 
	fn 							{ \pos s -> TokenFn pos }
	true						{ \pos s -> TokenTrue pos }
	false						{ \pos s -> TokenFalse pos }
	extern						{ \pos s -> TokenExtern pos }
	\+							{ \pos s -> TokenAdd pos }
	\-							{ \pos s -> TokenSub pos }
	\/							{ \pos s -> TokenDiv pos }
	\*							{ \pos s -> TokenMul pos }
	\=							{ \pos s -> TokenEqual pos }
	\=\=						{ \pos s -> TokenEquals pos }
    \!\=						{ \pos s -> TokenDiff pos }
    \>                          { \pos s -> TokenGt pos }
    \>\=                        { \pos s -> TokenGtEq pos }
    \<                          { \pos s -> TokenLess pos }
    \<\=                        { \pos s -> TokenLessEq pos }
	$alpha [$alpha $digit \_]*	{ \pos s -> TokenSymbol s pos }
	$digit+						{ \pos s -> TokenInt (read s) pos }
	$digit\.digit+				{ \pos s -> TokenFloat (read s) pos }
	\(							{ \pos s -> TokenLParen pos }
	\)							{ \pos s -> TokenRParen pos }
	\{							{ \pos s -> TokenLBrace pos }
	\}							{ \pos s -> TokenRBrace pos }
	\[							{ \pos s -> TokenLBracket pos }
	\]							{ \pos s -> TokenRBracket pos }
	\r?\n 					    { \pos s -> TokenNewline pos }
	\, 							{ \pos s -> TokenComma pos }
    not                         { \pos s -> TokenNot pos }

{
data Token 
    = TokenFn AlexPosn
    | TokenFalse AlexPosn
    | TokenTrue AlexPosn
    | TokenExtern AlexPosn
    | TokenAdd AlexPosn
    | TokenSub AlexPosn
    | TokenMul AlexPosn
    | TokenDiv AlexPosn
    | TokenEqual AlexPosn
    | TokenEquals AlexPosn
    | TokenDiff AlexPosn
    | TokenGt AlexPosn
    | TokenGtEq AlexPosn
    | TokenLess AlexPosn
    | TokenLessEq AlexPosn
    | TokenNot AlexPosn
    | TokenSymbol String AlexPosn
    | TokenInt Int AlexPosn
    | TokenFloat Float AlexPosn
    | TokenLParen AlexPosn
    | TokenRParen AlexPosn
    | TokenLBrace AlexPosn
    | TokenRBrace AlexPosn
    | TokenLBracket AlexPosn
    | TokenRBracket AlexPosn
    | TokenEOF AlexPosn
    | TokenNewline AlexPosn
    | TokenComma AlexPosn
    deriving (Eq, Show)

scanTokens :: String -> Either String [Token]
scanTokens str = go(alexStartPos, '\n', [], str)
        where 
            go inp@(pos, _, (t:tokens), str) = case alexScan inp 0 of 
                AlexEOF -> t:tokens
                AlexError ((AlexPn _ l c), _, _, _) -> throwError $ "lexical error in file at " ++ (show l) ++ " line, " ++ (show c) ++ " column"
                AlexSkip newInput len -> go newInput
                AlexToken newInput len act -> (act pos (take len str)): go newInput
}