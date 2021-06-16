module VariableNotInScope where

import Prelude (Int, String, Bool(..))


vni001 :: Int
vni001 = vni9999

vni002 = putStr

vni003 :: Int
vni003 = 1 + 2 * 3
