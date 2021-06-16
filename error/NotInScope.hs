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

cnm009 :: Int -> IO ()
cnm009 i = putStr
