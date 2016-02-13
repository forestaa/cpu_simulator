module Main where


import System.Environment
import Sim.Environment
import Sim.Type

main :: IO()
main = do
   (src:libsrc:_) <- getArgs
   contents <- readFile src
   libcontents <- readFile libsrc
   let program = map words $ lines contents
       lib     = map words $ lines libcontents
       union   = program ++ lib
       (labelmap, env) = prepare union
   print env
   print labelmap
