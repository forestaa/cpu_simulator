-- module Instruction where

import           Data.Bits
import           Data.Word
import qualified Data.Map as M

-- type definition

type Inum = Int
type Imm = Int
type Gpr = Int
type Fpr = Int

-- classify instructions by addressing mode
data Instruction = I Inum | II Inum Imm | IG Inum Gpr | IGI Inum Gpr Imm | IGF Inum Gpr Fpr | IGG Inum Gpr Fpr | IGGI Inum Gpr Gpr Imm | IGIG Inum Gpr Imm Gpr | IFIG Inum Fpr Imm Gpr | IGGG Inum Gpr Gpr Gpr | IFF Inum Fpr Fpr | IFFF Inum Fpr Fpr Fpr deriving (Show)

-- I    syscall 1
-- II   j 2,jal 3, bc1t 4,bc1f 5
-- IG   jr 6
-- IGI  blez 7,bgez 8,bltz 9,bgtz 10,lui 11
-- IGF  mfc1 12,mtc1 13
-- IGG  jalr 14
-- IGGI sll 15,srl 16,addi 17,addiu 18,ori 19,beq 20,bne 21,
-- IGIG lw 22, sw 23
-- IFIG lwc1 24,swc1 25
-- IGGG add 26,sub 27,slt 28,and 29,or 30,xor 31,sllv 32
-- IFF  inv.s 33,sqrt.s 34,mov.s 35,neg.s 36,trunc.w.s 37,cvt.s.w 38,c.eq.s 39,c.olt.s 40,c.ole.s 41
-- IFFF add.s 42,mul.s 43

readInstr :: Assembly -> Pc -> LabelMap -> Instruction
readInstr i pc map
    | inum == 1 || inum == 45  = I inum
    | 2 <= inum && inum <= 3   = II inum (labelToAbsAddr map (i !! 2))
    | 4 <= inum && inum <= 5   = II inum (offset pc map (i !! 3))
    | inum == 6                = IG inum (regAddr gprMap (i !! 2))
    | 7 <= inum && inum <= 10  = IGI inum (regAddr gprMap (i !! 2)) (offset pc map (i !! 3))
    | inum == 11               = IGI inum (regAddr gprMap (i !! 2)) (read (i !! 3))
    | 12 <= inum && inum <= 13 = IGF inum (regAddr gprMap (i !! 2)) (regAddr fprMap (i !! 3))
    | inum == 14               = IGG inum (regAddr gprMap (i !! 2)) (regAddr gprMap (i !! 3))
    | 15 <= inum && inum <= 19 = IGGI inum (regAddr gprMap (i !! 2)) (regAddr gprMap (i !! 3)) (read (i !! 4))
    | 20 <= inum && inum <= 21 = IGGI inum (regAddr gprMap (i !! 2)) (regAddr gprMap (i !! 3)) (offset pc map (i !! 4))
    | 22 <= inum && inum <= 23 = IGIG inum (regAddr gprMap (i !! 2)) (read (i !! 3)) (regAddr gprMap (i !! 4))
    | 24 <= inum && inum <= 25 = IFIG inum (regAddr fprMap (i !! 2)) (read (i !! 3)) (regAddr gprMap (i !! 4))
    | 26 <= inum && inum <= 32 = IGGG inum (regAddr gprMap (i !! 2)) (regAddr gprMap (i !! 3)) (regAddr gprMap (i !! 4))
    | 33 <= inum && inum <= 38 = IFF inum (regAddr fprMap (i !! 2)) (regAddr fprMap (i !! 3))
    | 39 <= inum && inum <= 41 = IFF inum (regAddr fprMap (i !! 3)) (regAddr fprMap (i !! 4))
    | 42 <= inum && inum <= 43 = IFFF inum (regAddr fprMap (i !! 2)) (regAddr fprMap (i !! 3)) (regAddr fprMap (i !! 4))
  where
    inum = unwrapper 45 $ M.lookup (i !! 1) instrNumMap

removecomma :: String -> String
removecomma = filter (/= ',')

regAddr :: M.Map String a -> String -> a
regAddr map s = unwrapper (error ("no such register: " ++ reg)) $ M.lookup map reg
   where
     reg = removecomma s

 
instrNumMap :: M.Map String Inum
instrNumMap = M.fromList [ ("syscall"  , 1)
	      		 , ("j"        , 2)
			 , ("jal"      , 3)
			 , ("bc1t"     , 4)
			 , ("bc1f"     , 5)
			 , ("jr"       , 6)
			 , ("blez"     , 7)
			 , ("bgez"     , 8)
			 , ("bltz"     , 9)
			 , ("bgtz"     , 10)
			 , ("lui"      , 11)
			 , ("mfc1"     , 12)
			 , ("mtc1"     , 13)
			 , ("jalr"     , 14)
			 , ("sll"      , 15)
			 , ("srl"      , 16)
			 , ("addi"     , 17)
			 , ("addiu"    , 18)
			 , ("ori"      , 19)
			 , ("beq"      , 20)
			 , ("bne"      , 21)
			 , ("lw"       , 22)
			 , ("sw"       , 23)
			 , ("lwc1"     , 24)
			 , ("swc1"     , 25)
			 , ("add"      , 26)
			 , ("sub"      , 27)
			 , ("slt"      , 28)
			 , ("and"      , 29)
			 , ("or"       , 30)
			 , ("xor"      , 31)
			 , ("sllv"     , 32)
			 , ("inv.s"    , 33)
			 , ("sqrt.s"   , 34)
			 , ("mov.s"    , 35)
			 , ("neg.s"    , 36)
			 , ("trunc.w.s", 37)
			 , ("cvt.s.w"  , 38)
			 , ("c.eq.s"   , 39)
			 , ("c.olt.s"  , 40)
			 , ("c.ole.s"  , 41)
			 , ("add.s"    , 42)
			 , ("mov.s"    , 43) ]

gprMap :: M.Map String Gpr
gprMap = M.fromList [ ("$zero", 0)
		    , ("$at"  , 1)
		    , ("$v0"  , 2)
		    , ("$v1"  , 3)
		    , ("$a0"  , 4)
		    , ("$a1"  , 5)
		    , ("$a2"  , 6)
		    , ("$a3"  , 7)
		    , ("$t0"  , 8)
		    , ("$t1"  , 9)
		    , ("$t2"  , 10)
		    , ("$t3"  , 11)
		    , ("$t4"  , 12)
		    , ("$t5"  , 13)
		    , ("$t6"  , 14)
		    , ("$t7"  , 15)
		    , ("$s0"  , 16)
		    , ("$s1"  , 17)
		    , ("$s2"  , 18)
		    , ("$s3"  , 19)
		    , ("$s4"  , 20)
		    , ("$s5"  , 21)
		    , ("$s6"  , 22)
		    , ("$s7"  , 23)
		    , ("$t8"  , 24)
		    , ("$t9"  , 25)
		    , ("$k0"  , 26)
		    , ("$k1"  , 27)
		    , ("$gp"  , 28)
		    , ("$sp"  , 29)
		    , ("$hp"  , 30)
		    , ("$ra"  , 31)
       	 	    , ("$r0"  , 0)
		    , ("$r1"  , 1)
		    , ("$r2"  , 2)
		    , ("$r3"  , 3)
		    , ("$r4"  , 4)
		    , ("$r5"  , 5)
		    , ("$r6"  , 6)
		    , ("$r7"  , 7)
		    , ("$r8"  , 8)
		    , ("$r9"  , 9)
		    , ("$r10" , 10)
		    , ("$r11" , 11)
		    , ("$r12" , 12)
		    , ("$r13" , 13)
		    , ("$r14" , 14)
		    , ("$r15" , 15)
		    , ("$r16" , 16)
		    , ("$r17" , 17)
		    , ("$r18" , 18)
		    , ("$r19" , 19)
		    , ("$r20" , 20)
		    , ("$r21" , 21)
		    , ("$r22" , 22)
		    , ("$r23" , 23)
		    , ("$r24" , 24)
		    , ("$r25" , 25)
		    , ("$r26" , 26)
		    , ("$r27" , 27)
		    , ("$r28" , 28)
		    , ("$r29" , 29)
		    , ("$r30" , 30)
		    , ("$r31" , 31) ]

fprMap :: M.Map String Fpr
fprMap = M.fromList [ ("$f0", 0)
       	 	    , ("$f1", 1)
                    , ("$f2", 2)
                    , ("$f3", 3)
                    , ("$f4", 4)
                    , ("$f5", 5)
                    , ("$f6", 6)
                    , ("$f7", 7)
                    , ("$f8", 8)
                    , ("$f9", 9)
                    , ("$f10", 10)
                    , ("$f11", 11)
                    , ("$f12", 12)
                    , ("$f13", 13)
                    , ("$f14", 14)
                    , ("$f15", 15)
                    , ("$f16", 16)
                    , ("$f17", 17)
                    , ("$f18", 18)
                    , ("$f19", 19)
                    , ("$f20", 20)
                    , ("$f21", 21)
                    , ("$f22", 22)
                    , ("$f23", 23)
                    , ("$f24", 24)
                    , ("$f25", 25)
                    , ("$f26", 26)
                    , ("$f27", 27)
                    , ("$f28", 28)
                    , ("$f29", 29)
                    , ("$f30", 30)
                    , ("$f31", 31) ]

