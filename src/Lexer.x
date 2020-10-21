{
module Lexer(
	Token(...),
	scanTokens
) where
	import Syntax

	data Token 
	  = TokenFn
	  | TokenFalse
	  | TokenTrue
	  | TokenExtern
	  | TokenAdd
	  | TokenSub
	  | TokenMul
	  | TokenDiv
	  | TokenEqual
	  | TokenEquals
	  | TokenDiff
	  | TokenSymbol String
	  | TokenInt Int
	  | TokenFloat Float
	  | TokenLParen
	  | TokenRParen
	  | TokenLBrace
	  | TokenRBrace
	  | TokenLBracket
	  | TokenRBracket
	  | TokenEOF
	  | TokenNewline
	  | TokenComma
	  deriving (Eq, Show)
	
	scanTokens :: String -> [Token]
	scanTokens = alexScanTokens
}

%wrapper "basic"

$digit = [0-9]
$hexaDigit = [0-9A-F]
$alpha = [a-zA-Z]

tokens :- 

	-- Content Ignore
	$white+		;
	
	"#".*  		; -- line coments
	"/*".*"*/"	; -- multiline coments

	-- Syntax 
	fn 							{\s -> TokenFn}
	true						{\s -> TokenTrue}
	false						{\s -> TokenFalse}
	extern						{\s -> TokenExtern}
	\+							{\s -> TokenAdd}
	\-							{\s -> TokenSub}
	\/							{\s -> TokenDiv}
	\*							{\s -> TokenMul}
	\=							{\s -> TokenEqual}
	\=\=						{\s -> TokenEquals}
	\!\=						{\s -> TokenDiff}
	$alpha [$alpha $digit \_]*	{\s -> TokenSymbol s}
	$digit+						{\s -> TokenInt (read s)}
	$digit\.digit+				{\s -> TokenFloat (read s)}
	\(							{\s -> TokenLParen}
	\)							{\s -> TokenRParen}
	\{							{\s -> TokenLBrace}
	\}							{\s -> TokenRBrace}
	\[							{\s -> TokenLBracket}
	\]							{\s -> TokenRBracket}
	\r?\n 						{\s -> TokenNewline}
	\, 							{\s -> TokenComma}

