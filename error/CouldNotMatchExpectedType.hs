module CouldNotMatchExpectedType where

import Prelude(Int, String, ([]))

cnm001 :: Int
cnm001 = "1"

cnm002 :: Int
cnm002 = 0.0

cnm003 :: String
cnm003 = 'a'

cnm004 :: Int
cnm004 = [1]

cnm005 :: [Int] -> Int
cnm005 [] = 0
cnm005 (x : xs) = xs

cnm006 :: Int
cnm006 = a1 + a2
  where
    a1 :: Double
    a1 = 1
    a2 :: Float
    a2 = 2.0

cnm007 :: ()
cnm007 = (1, 2)

cnm008 :: [Int]
cnm008 = map (const ()) []


