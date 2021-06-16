module NotInScope where

import Prelude ()


nis001 :: Integer
nis001 = 1

instance Semigroup Integer where
  (<>) = (+)

data Ext a = Original a | Neutral
instance (Semigroup a) => Monoid (Ext a) where
  mempty = Neutral
  mappend Neutral      a             = a
  mappend a            Neutral       = a
  mappend (Original a) (Original b) = Original (a <> b)

nis002 :: Int -> IO ()
nis002 i = putStr

nis003 :: Double -> Double
nis003 i = i

nis004 :: Num a => a -> String
nis004 x = x


