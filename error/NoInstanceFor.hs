module NoInstanceFor where

import Prelude (String, Integer, (+), (++), Monoid(..), Semigroup(..), (<>))
import Data.Monoid

instance Semigroup Integer where
  (<>) = (++)


nif001 :: Integer -> Integer
nif001 x = x <> x

instance Monoid Integer where
  mempty = 0
  mappend = (+)




