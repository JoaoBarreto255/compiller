{-# OPTIONS_GHC -w #-}
{-# OPTIONS -cpp #-}
module Parser(
  parseExpr,
  parseTokens
) where
import Lexer
import Syntax

import Control.Monad.Except
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Expr)
	| HappyAbsSyn8 ([Expr])

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,169) ([32768,4,0,8192,0,0,0,32768,0,0,0,0,0,0,64,0,0,0,2048,0,32,0,0,128,0,0,0,0,0,16,2304,0,0,0,8192,32768,16405,448,0,0,0,0,2048,0,0,0,0,48,0,15360,30,0,0,0,0,0,0,0,0,0,172,3586,0,4100,112,11008,32896,3,0,0,0,0,0,0,258,0,0,16,0,0,256,0,0,0,0,1024,0,0,0,22528,1025,28,2752,57376,0,0,2,0,2048,0,0,0,0,0,0,0,4100,112,8192,32896,3,256,7172,0,8200,224,16384,256,7,512,14344,0,16400,448,32768,512,14,1024,28688,0,32800,896,22528,1025,28,0,0,0,0,0,0,0,0,30720,0,0,960,0,0,30,0,61440,0,0,0,0,0,0,0,32768,1,0,3072,0,0,0,0,0,32768,0,0,32,0,0,0,0,0,16,0,0,0,0,0,45056,2050,56,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_expr","PROGRAM","FNLIST","FNDECL","FNHEAD","ARGLIST","STMT","ASSIGNEXPR","BOOLEXPR","CMPEXPR","EXPR","ATOM","PARAMLIST","fn","false","true","extern","not","'+'","'-'","'*'","'/'","'='","'=='","'!='","'>'","'>='","'<'","'<='","'('","')'","'{'","'}'","'['","']'","','","NL","INT","FLOAT","SYM","%eof"]
        bit_start = st * 43
        bit_end = (st + 1) * 43
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..42]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

happyActOffsets :: Happy_Data_Array.Array Int Int
happyActOffsets = Happy_Data_Array.listArray (0,70) ([19,9,-24,-23,0,8,-6,23,25,0,107,19,105,-1,0,109,0,16,53,0,0,0,5,27,5,0,0,1,117,111,0,113,0,5,5,119,122,0,0,27,27,27,27,27,27,27,27,27,27,12,0,0,0,80,80,80,80,0,0,103,103,0,121,123,0,115,0,0,38,0,0
	])

happyGotoOffsets :: Happy_Data_Array.Array Int Int
happyGotoOffsets = Happy_Data_Array.listArray (0,70) ([56,0,131,0,0,34,137,0,0,0,0,102,139,41,0,0,0,0,0,0,0,0,83,104,87,0,0,0,0,0,0,0,0,91,69,0,0,0,0,106,108,110,112,114,116,118,120,97,100,65,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,141,0,0,74,0,0
	])

happyAdjustOffset :: Int -> Int
happyAdjustOffset = id

happyDefActions :: Happy_Data_Array.Array Int Int
happyDefActions = Happy_Data_Array.listArray (0,70) ([0,0,0,0,-3,-5,0,0,0,-4,0,0,-10,0,-6,-13,-15,-21,-26,-32,-20,-19,0,0,0,-35,-36,-37,0,0,-2,-9,-7,0,-40,0,-37,-31,-18,0,0,0,0,0,0,0,0,0,0,-12,-11,-17,-16,-25,-24,-23,-22,-30,-29,-28,-27,-33,-39,0,-14,-10,-8,-34,-40,-38
	])

happyCheck :: Happy_Data_Array.Array Int Int
happyCheck = Happy_Data_Array.listArray (0,169) ([-1,2,3,27,5,28,7,2,3,1,5,10,7,4,2,3,17,5,17,7,1,27,17,4,25,26,27,11,12,17,25,26,27,10,7,1,2,25,26,27,2,3,17,5,17,7,5,6,7,8,9,10,25,26,27,17,0,1,2,6,7,8,9,25,26,27,13,14,15,16,5,6,7,8,9,10,7,8,9,10,11,7,8,9,10,11,6,7,8,9,7,8,9,10,7,8,9,10,7,8,9,10,0,1,2,8,9,10,8,9,10,8,9,9,10,9,10,9,10,9,10,9,10,9,10,9,10,9,10,9,10,24,27,24,3,18,23,18,27,17,3,18,27,4,23,4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	])

happyTable :: Happy_Data_Array.Array Int Int
happyTable = Happy_Data_Array.listArray (0,169) ([0,21,22,9,23,-1,24,21,22,7,23,34,24,3,21,22,25,23,35,24,7,9,25,3,26,27,28,48,49,25,26,27,37,14,24,9,5,26,27,28,21,22,13,23,25,24,14,15,16,17,18,19,26,27,37,25,3,4,5,40,41,42,43,26,27,37,44,45,46,47,50,15,16,17,18,19,62,17,18,19,63,62,17,18,19,69,40,41,42,43,38,17,18,19,35,17,18,19,64,17,18,19,30,4,5,52,18,19,51,18,19,42,43,37,19,60,19,59,19,58,19,57,19,56,19,55,19,54,19,53,19,12,30,50,10,33,66,62,32,35,7,68,30,28,69,66,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

happyReduceArr = Happy_Data_Array.array (1, 39) [
	(1 , happyReduce_1),
	(2 , happyReduce_2),
	(3 , happyReduce_3),
	(4 , happyReduce_4),
	(5 , happyReduce_5),
	(6 , happyReduce_6),
	(7 , happyReduce_7),
	(8 , happyReduce_8),
	(9 , happyReduce_9),
	(10 , happyReduce_10),
	(11 , happyReduce_11),
	(12 , happyReduce_12),
	(13 , happyReduce_13),
	(14 , happyReduce_14),
	(15 , happyReduce_15),
	(16 , happyReduce_16),
	(17 , happyReduce_17),
	(18 , happyReduce_18),
	(19 , happyReduce_19),
	(20 , happyReduce_20),
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26),
	(27 , happyReduce_27),
	(28 , happyReduce_28),
	(29 , happyReduce_29),
	(30 , happyReduce_30),
	(31 , happyReduce_31),
	(32 , happyReduce_32),
	(33 , happyReduce_33),
	(34 , happyReduce_34),
	(35 , happyReduce_35),
	(36 , happyReduce_36),
	(37 , happyReduce_37),
	(38 , happyReduce_38),
	(39 , happyReduce_39)
	]

happy_n_terms = 29 :: Int
happy_n_nonterms = 12 :: Int

happyReduce_1 = happyReduce 4 0 happyReduction_1
happyReduction_1 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (let Program (x:xs) fns = happy_var_4 in Program (happy_var_2:x:xs) fns
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_1  0 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_2  1 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (let Program _ (x:xs) = happy_var_2 in Program [] (happy_var_1:xs)
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  1 happyReduction_4
happyReduction_4 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Program [] [happy_var_1]
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happyReduce 4 2 happyReduction_5
happyReduction_5 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (let Extern name args = happy_var_2 in Function name args happy_var_4
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 4 3 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSymbol happy_var_1 _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Extern happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 4 4 happyReduction_7
happyReduction_7 ((HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSymbol happy_var_2 _)) `HappyStk`
	(HappyTerminal (TokenSymbol happy_var_1 _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (let (x:xs) = happy_var_4 in (Var happy_var_2 (Type happy_var_1)):x:xs
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_2  4 happyReduction_8
happyReduction_8 (HappyTerminal (TokenSymbol happy_var_2 _))
	(HappyTerminal (TokenSymbol happy_var_1 _))
	 =  HappyAbsSyn8
		 ([Var happy_var_2 (Type happy_var_1)]
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_0  4 happyReduction_9
happyReduction_9  =  HappyAbsSyn8
		 ([]
	)

happyReduce_10 = happySpecReduce_3  5 happyReduction_10
happyReduction_10 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (let Body (x:xs) = happy_var_3 in Body (happy_var_1:x:xs)
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_2  5 happyReduction_11
happyReduction_11 _
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Body [happy_var_1]
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  5 happyReduction_12
happyReduction_12 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Body [happy_var_1]
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  6 happyReduction_13
happyReduction_13 (HappyAbsSyn4  happy_var_3)
	_
	(HappyTerminal (TokenSymbol happy_var_1 _))
	 =  HappyAbsSyn4
		 (Assign happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  6 happyReduction_14
happyReduction_14 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  7 happyReduction_15
happyReduction_15 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Equals happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  7 happyReduction_16
happyReduction_16 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Difference happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_2  7 happyReduction_17
happyReduction_17 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Not happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  7 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn4
		 (Integer 1
	)

happyReduce_19 = happySpecReduce_1  7 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn4
		 (Integer 0
	)

happyReduce_20 = happySpecReduce_1  7 happyReduction_20
happyReduction_20 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  8 happyReduction_21
happyReduction_21 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Less happy_var_3 happy_var_1
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  8 happyReduction_22
happyReduction_22 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp LessEq happy_var_3 happy_var_1
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  8 happyReduction_23
happyReduction_23 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Less happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  8 happyReduction_24
happyReduction_24 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp LessEq happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  8 happyReduction_25
happyReduction_25 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  9 happyReduction_26
happyReduction_26 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Add happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  9 happyReduction_27
happyReduction_27 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Subtract happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  9 happyReduction_28
happyReduction_28 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Times happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  9 happyReduction_29
happyReduction_29 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Division happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_2  9 happyReduction_30
happyReduction_30 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Negate happy_var_2
	)
happyReduction_30 _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  9 happyReduction_31
happyReduction_31 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  10 happyReduction_32
happyReduction_32 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happyReduce 4 10 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSymbol happy_var_1 _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Call happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happySpecReduce_1  10 happyReduction_34
happyReduction_34 (HappyTerminal (TokenInt happy_var_1 _))
	 =  HappyAbsSyn4
		 (Integer happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  10 happyReduction_35
happyReduction_35 (HappyTerminal (TokenFloat happy_var_1 _))
	 =  HappyAbsSyn4
		 (Float happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  10 happyReduction_36
happyReduction_36 (HappyTerminal (TokenSymbol happy_var_1 _))
	 =  HappyAbsSyn4
		 (Var happy_var_1 CallVar
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  11 happyReduction_37
happyReduction_37 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn8
		 (let (x:xs) = happy_var_3 in (happy_var_1:x:xs)
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  11 happyReduction_38
happyReduction_38 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_0  11 happyReduction_39
happyReduction_39  =  HappyAbsSyn8
		 ([]
	)

happyNewToken action sts stk [] =
	happyDoAction 28 notHappyAtAll action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	TokenFn happy_dollar_dollar -> cont 1;
	TokenFalse happy_dollar_dollar -> cont 2;
	TokenTrue happy_dollar_dollar -> cont 3;
	TokenExtern happy_dollar_dollar -> cont 4;
	TokenNot happy_dollar_dollar -> cont 5;
	TokenAdd happy_dollar_dollar -> cont 6;
	TokenSub happy_dollar_dollar -> cont 7;
	TokenMul happy_dollar_dollar -> cont 8;
	TokenDiv happy_dollar_dollar -> cont 9;
	TokenEqual happy_dollar_dollar -> cont 10;
	TokenEquals happy_dollar_dollar -> cont 11;
	TokenDiff happy_dollar_dollar -> cont 12;
	TokenGt happy_dollar_dollar -> cont 13;
	TokenGtEq happy_dollar_dollar -> cont 14;
	TokenLess happy_dollar_dollar -> cont 15;
	TokenLessEq happy_dollar_dollar -> cont 16;
	TokenLParen happy_dollar_dollar -> cont 17;
	TokenRParen happy_dollar_dollar -> cont 18;
	TokenLBrace happy_dollar_dollar -> cont 19;
	TokenRBrace happy_dollar_dollar -> cont 20;
	TokenLBracket happy_dollar_dollar -> cont 21;
	TokenRBracket happy_dollar_dollar -> cont 22;
	TokenComma happy_dollar_dollar -> cont 23;
	TokenNewline happy_dollar_dollar -> cont 24;
	TokenInt happy_dollar_dollar _ -> cont 25;
	TokenFloat happy_dollar_dollar _ -> cont 26;
	TokenSymbol happy_dollar_dollar _ -> cont 27;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 28 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Except String a -> (a -> Except String b) -> Except String b
happyThen = (>>=)
happyReturn :: () => a -> Except String a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Except String a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> Except String a
happyError' = (\(tokens, _) -> parseError tokens)
expr tks = happySomeParser where
 happySomeParser = happyThen (happyParse 0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> Except String a
parseError (l:ls) = throwError $ "Unexpected token: " ++ (showTokenError l)
parseError [] = throwError "Unexpected end of input"

parseExpr :: String -> Either String Expr
parseExpr input = runExcept $ do
  tokenStream <- scanTokens input
  expr $ reverse tokenStream

parseTokens :: String -> Either String [Token]
parseTokens = runExcept . scanTokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (0) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
        = {- nothing -}
          case action of
                (0)           -> {- nothing -}
                                     happyFail (happyExpListPerState ((st) :: Int)) i tk st
                (-1)          -> {- nothing -}
                                     happyAccept i tk st
                n | (n < ((0) :: Int)) -> {- nothing -}
                                                   (happyReduceArr Happy_Data_Array.! rule) i tk st
                                                   where rule = ((negate ((n + ((1) :: Int)))))
                n                 -> {- nothing -}
                                     happyShift new_state i tk st
                                     where new_state = (n - ((1) :: Int))
   where off    = happyAdjustOffset (indexShortOffAddr happyActOffsets st)
         off_i  = (off + i)
         check  = if (off_i >= ((0) :: Int))
                  then (indexShortOffAddr happyCheck off_i == i)
                  else False
         action
          | check     = indexShortOffAddr happyTable off_i
          | otherwise = indexShortOffAddr happyDefActions st












indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)













-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (0) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (0) tk st sts stk
     = happyFail [] (0) tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (0) tk st sts stk
     = happyFail [] (0) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (0) tk st sts stk
     = happyFail [] (0) tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (0) tk st sts stk
     = happyFail [] (0) tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (0) tk st sts stk
     = happyFail [] (0) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@((HappyCons (st1@(action)) (_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn (0) tk st sts stk
     = happyFail [] (0) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (0) tk st sts stk
     = happyFail [] (0) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
         let drop_stk = happyDropStk k stk

             off = happyAdjustOffset (indexShortOffAddr happyGotoOffsets st1)
             off_i = (off + nt)
             new_state = indexShortOffAddr happyTable off_i




          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   {- nothing -}
   happyDoAction j tk new_state
   where off = happyAdjustOffset (indexShortOffAddr happyGotoOffsets st)
         off_i = (off + nt)
         new_state = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (0) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (action) sts stk =
--      trace "entering error recovery" $
        happyDoAction (0) tk action sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
