module Sim.Type where

import           Data.Bits
import           Data.Word
import           Text.Read
import qualified Data.Map as M

type Pc = Int
type Assembly = [String]
type Program = [Assembly]
type Label = String
type Address = Int
type LabelMap =  M.Map Label Address
type DataLabelMap = M.Map Label Address
data Environment = Env {datamap :: DataLabelMap, heap :: [Int], hp :: Int} deriving Show


initEnv :: Environment
initEnv = Env M.empty [] 0

initLabelMap :: LabelMap
initLabelMap = M.empty

unwrap :: a -> Maybe a -> a
unwrap _ (Just b) = b
unwrap a Nothing = a

isLabel :: Assembly -> Bool
isLabel = (==) ':' . last . head

toLabel :: Assembly -> Label
toLabel = init . head

expandLI :: Assembly -> LabelMap -> DataLabelMap -> Program
expandLI i labelmap datamap 
    | 0 <= num && num < 65536 = [ori]
    | otherwise               = lui:[ori]
  where
    num = unwrap (searchLabel (i !! 2) labelmap datamap) $ readMaybe (i !! 2)
    upper = show $ shiftR (fromInteger $ toInteger num :: Word32) 16
    lower = show $ num .&. 0x0000ffff
    lui = ["lui", i !! 1, upper]
    ori = ["ori", i !! 1, "$zero", lower]

searchLabel :: Label -> LabelMap -> DataLabelMap -> Address
searchLabel label labelmap datamap = unwrap (unwrap (error $ "no such label: " ++ label) $ M.lookup label datamap) $ M.lookup label labelmap
