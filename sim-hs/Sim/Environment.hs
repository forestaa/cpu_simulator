module Sim.Environment where

import qualified Data.Map as M
import           Sim.Type


prepare :: Program -> (LabelMap, Environment)
prepare p = (map, env)
  where
    (text, datasec) = divideSec p ([], [])
    env = prepareData datasec initEnv
    initmap = prepareinitLabel text initLabelMap
    map = iterLabelMap text initmap env
    
prepareData :: Program -> Environment -> Environment
prepareData [] env = env
prepareData program@(i:is) env@(Env {datamap = map, heap = currheap, hp = currhp})
    | head i == ".word" = prepareData is $ env {heap = d:currheap, hp = 1 + currhp}
    | isLabel i         = prepareData is $ env {datamap = M.insert (toLabel i) currhp map}
    | otherwise         = prepareData is env
  where
    d = read (i !! 1)

iterLabelMap :: Program -> LabelMap -> Environment -> LabelMap
iterLabelMap text map env = if isFixpointLabelMap map newmap
                            then newmap
                            else iterLabelMap text newmap env 
  where
    newmap = prepareLabel text 0 env map
    
isFixpointLabelMap :: LabelMap -> LabelMap -> Bool
isFixpointLabelMap map newmap = foldr (&&) True boolmap
  where
    p x y = let bx = x < 65536
                by = y < 65536
            in (bx && by) || (not bx && not by)
    boolmap = M.intersectionWith p map newmap
    
prepareLabel :: Program -> Pc -> Environment -> LabelMap -> LabelMap
prepareLabel [] pc env map = map
prepareLabel program@(i:is) pc env map
    | isLabel i      = prepareLabel is pc env newmap
    | head i == "li" = prepareLabel newis pc env map
    | isnull i       = prepareLabel is pc env map
    | otherwise      = prepareLabel is (pc+1) env map
  where
    isnull i = null i || (head . head) i == '#'
    newmap = M.insert (toLabel i) pc map
    newis = expandLI i map (datamap env) ++ is

prepareinitLabel :: Program -> LabelMap -> LabelMap
prepareinitLabel [] map = map
prepareinitLabel (i:is) map
    | isLabel i = prepareinitLabel is newmap
    | otherwise = prepareinitLabel is map
  where
    newmap = M.insert (toLabel i) 0 map

divideSec :: Program -> (Program, Program) -> (Program, Program)
divideSec [] t = t
divideSec (i:is) (text, datasec)
    | head i == ".text" = divideSec rest (text ++ former, datasec)
    | head i == ".data" = divideSec rest (text, datasec ++ former)
  where
    p = (\x -> x /= ".text" && x /= ".data") . head
    (former, rest) = span p is

