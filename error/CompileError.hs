{-# LANGUAGE NoOverloadedStrings #-}
module CompileErrors where

import Prelude (Int, String, Bool(..), Semigroup(..),IO(), 
                Num(..),
                map,
                const
               )
-- This file contains many variant of type error. Correct the error.
-- I'd like to order getting compilation error from top to bottom in the file.

-- Resolve compilation error. There are many possibility to resolve erros.
a000 :: Int
a000 = 1   -- DROP

--a001 :: Int
--a001 = "1"

--a002 :: Int
--a002 = [1]

--a003 :: String
a003 = 2

--a004 :: [Int]
a004 = 1

--a005 :: [Int]
--a005 = map (const ()) []

--a006  :: Int -> Int
--a006 = 6

--a007 :: [Int] -> Int
--a007 [] = 0
--a007 (x : xs) = xs


cnm009 :: Int -> IO ()
cnm009 i = putStr

a008 :: Int
a008 = 1

--a010 = a8 + a9  -- cast is never be automatic in Haskell


--a011 :: ()
--a011 = (1, 2)


-- You cannot instanciate a type for multiple instances.
--instance Semigroup Integer where
--  (<>) = (+)
--instance Semigroup Integer where
--  (<>) = (*)  


data Ext a = Original a | Neutral

--instance (Semigroup a) => Monoid (Ext a) where
--  mempty = Neutral
--  mappend Neutral      a             = a
--  mappend a            Neutral       = a
--  mappend (Original a) (Original b) = Original (a <> b)

-- hole is important feature of GHC to know type.

--a12 :: String
--a12 = map _ [1,2,3]

