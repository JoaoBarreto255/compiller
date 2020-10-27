{-# OPTIONS_GHC -w #-}
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

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69 :: () => Int -> ({-HappyReduction (Except String) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Except String) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Except String) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Except String) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39 :: () => ({-HappyReduction (Except String) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Except String) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Except String) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Except String) HappyAbsSyn)

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

action_0 (16) = happyShift action_6
action_0 (19) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_4
action_0 (6) = happyGoto action_5
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (19) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (42) = happyShift action_8
action_2 (7) = happyGoto action_10
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (43) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_2

action_5 (16) = happyShift action_6
action_5 (5) = happyGoto action_9
action_5 (6) = happyGoto action_5
action_5 _ = happyReduce_4

action_6 (42) = happyShift action_8
action_6 (7) = happyGoto action_7
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (25) = happyShift action_13
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (32) = happyShift action_12
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_3

action_10 (39) = happyShift action_11
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (16) = happyShift action_6
action_11 (19) = happyShift action_2
action_11 (4) = happyGoto action_30
action_11 (5) = happyGoto action_4
action_11 (6) = happyGoto action_5
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (42) = happyShift action_29
action_12 (8) = happyGoto action_28
action_12 _ = happyReduce_9

action_13 (17) = happyShift action_20
action_13 (18) = happyShift action_21
action_13 (20) = happyShift action_22
action_13 (22) = happyShift action_23
action_13 (32) = happyShift action_24
action_13 (40) = happyShift action_25
action_13 (41) = happyShift action_26
action_13 (42) = happyShift action_27
action_13 (9) = happyGoto action_14
action_13 (10) = happyGoto action_15
action_13 (11) = happyGoto action_16
action_13 (12) = happyGoto action_17
action_13 (13) = happyGoto action_18
action_13 (14) = happyGoto action_19
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_5

action_15 (39) = happyShift action_49
action_15 _ = happyReduce_12

action_16 _ = happyReduce_14

action_17 (26) = happyShift action_47
action_17 (27) = happyShift action_48
action_17 _ = happyReduce_20

action_18 (21) = happyShift action_39
action_18 (22) = happyShift action_40
action_18 (23) = happyShift action_41
action_18 (24) = happyShift action_42
action_18 (28) = happyShift action_43
action_18 (29) = happyShift action_44
action_18 (30) = happyShift action_45
action_18 (31) = happyShift action_46
action_18 _ = happyReduce_25

action_19 _ = happyReduce_31

action_20 _ = happyReduce_19

action_21 _ = happyReduce_18

action_22 (17) = happyShift action_20
action_22 (18) = happyShift action_21
action_22 (20) = happyShift action_22
action_22 (22) = happyShift action_23
action_22 (32) = happyShift action_24
action_22 (40) = happyShift action_25
action_22 (41) = happyShift action_26
action_22 (42) = happyShift action_36
action_22 (11) = happyGoto action_38
action_22 (12) = happyGoto action_17
action_22 (13) = happyGoto action_18
action_22 (14) = happyGoto action_19
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (22) = happyShift action_23
action_23 (32) = happyShift action_24
action_23 (40) = happyShift action_25
action_23 (41) = happyShift action_26
action_23 (42) = happyShift action_36
action_23 (13) = happyGoto action_37
action_23 (14) = happyGoto action_19
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (17) = happyShift action_20
action_24 (18) = happyShift action_21
action_24 (20) = happyShift action_22
action_24 (22) = happyShift action_23
action_24 (32) = happyShift action_24
action_24 (40) = happyShift action_25
action_24 (41) = happyShift action_26
action_24 (42) = happyShift action_36
action_24 (11) = happyGoto action_35
action_24 (12) = happyGoto action_17
action_24 (13) = happyGoto action_18
action_24 (14) = happyGoto action_19
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_34

action_26 _ = happyReduce_35

action_27 (25) = happyShift action_33
action_27 (32) = happyShift action_34
action_27 _ = happyReduce_36

action_28 (33) = happyShift action_32
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (42) = happyShift action_31
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_1

action_31 (38) = happyShift action_65
action_31 _ = happyReduce_8

action_32 _ = happyReduce_6

action_33 (17) = happyShift action_20
action_33 (18) = happyShift action_21
action_33 (20) = happyShift action_22
action_33 (22) = happyShift action_23
action_33 (32) = happyShift action_24
action_33 (40) = happyShift action_25
action_33 (41) = happyShift action_26
action_33 (42) = happyShift action_36
action_33 (11) = happyGoto action_64
action_33 (12) = happyGoto action_17
action_33 (13) = happyGoto action_18
action_33 (14) = happyGoto action_19
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (17) = happyShift action_20
action_34 (18) = happyShift action_21
action_34 (20) = happyShift action_22
action_34 (22) = happyShift action_23
action_34 (32) = happyShift action_24
action_34 (40) = happyShift action_25
action_34 (41) = happyShift action_26
action_34 (42) = happyShift action_36
action_34 (11) = happyGoto action_62
action_34 (12) = happyGoto action_17
action_34 (13) = happyGoto action_18
action_34 (14) = happyGoto action_19
action_34 (15) = happyGoto action_63
action_34 _ = happyReduce_39

action_35 (33) = happyShift action_61
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (32) = happyShift action_34
action_36 _ = happyReduce_36

action_37 _ = happyReduce_30

action_38 _ = happyReduce_17

action_39 (22) = happyShift action_23
action_39 (32) = happyShift action_24
action_39 (40) = happyShift action_25
action_39 (41) = happyShift action_26
action_39 (42) = happyShift action_36
action_39 (13) = happyGoto action_60
action_39 (14) = happyGoto action_19
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (22) = happyShift action_23
action_40 (32) = happyShift action_24
action_40 (40) = happyShift action_25
action_40 (41) = happyShift action_26
action_40 (42) = happyShift action_36
action_40 (13) = happyGoto action_59
action_40 (14) = happyGoto action_19
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (22) = happyShift action_23
action_41 (32) = happyShift action_24
action_41 (40) = happyShift action_25
action_41 (41) = happyShift action_26
action_41 (42) = happyShift action_36
action_41 (13) = happyGoto action_58
action_41 (14) = happyGoto action_19
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (22) = happyShift action_23
action_42 (32) = happyShift action_24
action_42 (40) = happyShift action_25
action_42 (41) = happyShift action_26
action_42 (42) = happyShift action_36
action_42 (13) = happyGoto action_57
action_42 (14) = happyGoto action_19
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (22) = happyShift action_23
action_43 (32) = happyShift action_24
action_43 (40) = happyShift action_25
action_43 (41) = happyShift action_26
action_43 (42) = happyShift action_36
action_43 (13) = happyGoto action_56
action_43 (14) = happyGoto action_19
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (22) = happyShift action_23
action_44 (32) = happyShift action_24
action_44 (40) = happyShift action_25
action_44 (41) = happyShift action_26
action_44 (42) = happyShift action_36
action_44 (13) = happyGoto action_55
action_44 (14) = happyGoto action_19
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (22) = happyShift action_23
action_45 (32) = happyShift action_24
action_45 (40) = happyShift action_25
action_45 (41) = happyShift action_26
action_45 (42) = happyShift action_36
action_45 (13) = happyGoto action_54
action_45 (14) = happyGoto action_19
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (22) = happyShift action_23
action_46 (32) = happyShift action_24
action_46 (40) = happyShift action_25
action_46 (41) = happyShift action_26
action_46 (42) = happyShift action_36
action_46 (13) = happyGoto action_53
action_46 (14) = happyGoto action_19
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (22) = happyShift action_23
action_47 (32) = happyShift action_24
action_47 (40) = happyShift action_25
action_47 (41) = happyShift action_26
action_47 (42) = happyShift action_36
action_47 (12) = happyGoto action_52
action_47 (13) = happyGoto action_18
action_47 (14) = happyGoto action_19
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (22) = happyShift action_23
action_48 (32) = happyShift action_24
action_48 (40) = happyShift action_25
action_48 (41) = happyShift action_26
action_48 (42) = happyShift action_36
action_48 (12) = happyGoto action_51
action_48 (13) = happyGoto action_18
action_48 (14) = happyGoto action_19
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (17) = happyShift action_20
action_49 (18) = happyShift action_21
action_49 (20) = happyShift action_22
action_49 (22) = happyShift action_23
action_49 (32) = happyShift action_24
action_49 (40) = happyShift action_25
action_49 (41) = happyShift action_26
action_49 (42) = happyShift action_27
action_49 (9) = happyGoto action_50
action_49 (10) = happyGoto action_15
action_49 (11) = happyGoto action_16
action_49 (12) = happyGoto action_17
action_49 (13) = happyGoto action_18
action_49 (14) = happyGoto action_19
action_49 _ = happyReduce_11

action_50 _ = happyReduce_10

action_51 _ = happyReduce_16

action_52 _ = happyReduce_15

action_53 (21) = happyShift action_39
action_53 (22) = happyShift action_40
action_53 (23) = happyShift action_41
action_53 (24) = happyShift action_42
action_53 _ = happyReduce_24

action_54 (21) = happyShift action_39
action_54 (22) = happyShift action_40
action_54 (23) = happyShift action_41
action_54 (24) = happyShift action_42
action_54 _ = happyReduce_23

action_55 (21) = happyShift action_39
action_55 (22) = happyShift action_40
action_55 (23) = happyShift action_41
action_55 (24) = happyShift action_42
action_55 _ = happyReduce_22

action_56 (21) = happyShift action_39
action_56 (22) = happyShift action_40
action_56 (23) = happyShift action_41
action_56 (24) = happyShift action_42
action_56 _ = happyReduce_21

action_57 _ = happyReduce_29

action_58 _ = happyReduce_28

action_59 (23) = happyShift action_41
action_59 (24) = happyShift action_42
action_59 _ = happyReduce_27

action_60 (23) = happyShift action_41
action_60 (24) = happyShift action_42
action_60 _ = happyReduce_26

action_61 _ = happyReduce_32

action_62 (38) = happyShift action_68
action_62 _ = happyReduce_38

action_63 (33) = happyShift action_67
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_13

action_65 (42) = happyShift action_29
action_65 (8) = happyGoto action_66
action_65 _ = happyReduce_9

action_66 _ = happyReduce_7

action_67 _ = happyReduce_33

action_68 (17) = happyShift action_20
action_68 (18) = happyShift action_21
action_68 (20) = happyShift action_22
action_68 (22) = happyShift action_23
action_68 (32) = happyShift action_24
action_68 (40) = happyShift action_25
action_68 (41) = happyShift action_26
action_68 (42) = happyShift action_36
action_68 (11) = happyGoto action_62
action_68 (12) = happyGoto action_17
action_68 (13) = happyGoto action_18
action_68 (14) = happyGoto action_19
action_68 (15) = happyGoto action_69
action_68 _ = happyReduce_39

action_69 _ = happyReduce_37

happyReduce_1 = happyReduce 4 4 happyReduction_1
happyReduction_1 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (let Program (x:xs) fns = happy_var_4 in Program (happy_var_2:x:xs) fns
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (let Program _ (x:xs) = happy_var_2 in Program [] (happy_var_1:xs)
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Program [] [happy_var_1]
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happyReduce 4 6 happyReduction_5
happyReduction_5 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (let Extern name args = happy_var_2 in Function name args happy_var_4
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 4 7 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSymbol happy_var_1 _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Extern happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 4 8 happyReduction_7
happyReduction_7 ((HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSymbol happy_var_2 _)) `HappyStk`
	(HappyTerminal (TokenSymbol happy_var_1 _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (let (x:xs) = happy_var_4 in (Var happy_var_2 (Type happy_var_1)):x:xs
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_2  8 happyReduction_8
happyReduction_8 (HappyTerminal (TokenSymbol happy_var_2 _))
	(HappyTerminal (TokenSymbol happy_var_1 _))
	 =  HappyAbsSyn8
		 ([Var happy_var_2 (Type happy_var_1)]
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_0  8 happyReduction_9
happyReduction_9  =  HappyAbsSyn8
		 ([]
	)

happyReduce_10 = happySpecReduce_3  9 happyReduction_10
happyReduction_10 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (let Body (x:xs) = happy_var_3 in Body (happy_var_1:x:xs)
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_2  9 happyReduction_11
happyReduction_11 _
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Body [happy_var_1]
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  9 happyReduction_12
happyReduction_12 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Body [happy_var_1]
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  10 happyReduction_13
happyReduction_13 (HappyAbsSyn4  happy_var_3)
	_
	(HappyTerminal (TokenSymbol happy_var_1 _))
	 =  HappyAbsSyn4
		 (Assign happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  10 happyReduction_14
happyReduction_14 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  11 happyReduction_15
happyReduction_15 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Equals happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  11 happyReduction_16
happyReduction_16 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Difference happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_2  11 happyReduction_17
happyReduction_17 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Not happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  11 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn4
		 (Integer 1
	)

happyReduce_19 = happySpecReduce_1  11 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn4
		 (Integer 0
	)

happyReduce_20 = happySpecReduce_1  11 happyReduction_20
happyReduction_20 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  12 happyReduction_21
happyReduction_21 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Less happy_var_3 happy_var_1
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  12 happyReduction_22
happyReduction_22 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp LessEq happy_var_3 happy_var_1
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  12 happyReduction_23
happyReduction_23 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Less happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  12 happyReduction_24
happyReduction_24 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp LessEq happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  12 happyReduction_25
happyReduction_25 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  13 happyReduction_26
happyReduction_26 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Add happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  13 happyReduction_27
happyReduction_27 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Subtract happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  13 happyReduction_28
happyReduction_28 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Times happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  13 happyReduction_29
happyReduction_29 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp Division happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_2  13 happyReduction_30
happyReduction_30 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Negate happy_var_2
	)
happyReduction_30 _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  13 happyReduction_31
happyReduction_31 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  14 happyReduction_32
happyReduction_32 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happyReduce 4 14 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSymbol happy_var_1 _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Call happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happySpecReduce_1  14 happyReduction_34
happyReduction_34 (HappyTerminal (TokenInt happy_var_1 _))
	 =  HappyAbsSyn4
		 (Integer happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  14 happyReduction_35
happyReduction_35 (HappyTerminal (TokenFloat happy_var_1 _))
	 =  HappyAbsSyn4
		 (Float happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  14 happyReduction_36
happyReduction_36 (HappyTerminal (TokenSymbol happy_var_1 _))
	 =  HappyAbsSyn4
		 (Var happy_var_1 CallVar
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  15 happyReduction_37
happyReduction_37 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn8
		 (let (x:xs) = happy_var_3 in (happy_var_1:x:xs)
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  15 happyReduction_38
happyReduction_38 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_0  15 happyReduction_39
happyReduction_39  =  HappyAbsSyn8
		 ([]
	)

happyNewToken action sts stk [] =
	action 43 43 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenFn happy_dollar_dollar -> cont 16;
	TokenFalse happy_dollar_dollar -> cont 17;
	TokenTrue happy_dollar_dollar -> cont 18;
	TokenExtern happy_dollar_dollar -> cont 19;
	TokenNot happy_dollar_dollar -> cont 20;
	TokenAdd happy_dollar_dollar -> cont 21;
	TokenSub happy_dollar_dollar -> cont 22;
	TokenMul happy_dollar_dollar -> cont 23;
	TokenDiv happy_dollar_dollar -> cont 24;
	TokenEqual happy_dollar_dollar -> cont 25;
	TokenEquals happy_dollar_dollar -> cont 26;
	TokenDiff happy_dollar_dollar -> cont 27;
	TokenGt happy_dollar_dollar -> cont 28;
	TokenGtEq happy_dollar_dollar -> cont 29;
	TokenLess happy_dollar_dollar -> cont 30;
	TokenLessEq happy_dollar_dollar -> cont 31;
	TokenLParen happy_dollar_dollar -> cont 32;
	TokenRParen happy_dollar_dollar -> cont 33;
	TokenLBrace happy_dollar_dollar -> cont 34;
	TokenRBrace happy_dollar_dollar -> cont 35;
	TokenLBracket happy_dollar_dollar -> cont 36;
	TokenRBracket happy_dollar_dollar -> cont 37;
	TokenComma happy_dollar_dollar -> cont 38;
	TokenNewline happy_dollar_dollar -> cont 39;
	TokenInt happy_dollar_dollar _ -> cont 40;
	TokenFloat happy_dollar_dollar _ -> cont 41;
	TokenSymbol happy_dollar_dollar _ -> cont 42;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 43 tk tks = happyError' (tks, explist)
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
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> Except String a
parseError (l:ls) = throwError (show l)
parseError [] = throwError "Unexpected end of input"

parseExpr :: String -> Either String Expr
parseExpr input = runExcept $ do
  tokenStream <- scanTokens input
  expr tokenStream

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
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
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
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

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
