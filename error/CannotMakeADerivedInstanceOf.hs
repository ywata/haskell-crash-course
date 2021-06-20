module CannotMakeDerivedInstanceOf where

import Test.QuickCheck

data Nat = S | Z Nat
  deriving(Arbitrary)
