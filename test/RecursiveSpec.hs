{-# LANGUAGE ScopedTypeVariables #-}
module RecursiveSpec where

import Prelude (($), Int, Num(..), (.), Eq(..), Bool(..), Integral(..), id, (>>=), return)
import Prelude (Show(..))
import Recursive

import Test.QuickCheck
import Test.QuickCheck.Arbitrary
import Test.Hspec
import Test.Hspec.QuickCheck

import Debug.Trace

spec :: Spec
spec = do
  -- Unit test example.
  describe "length test" $ do
    it "length 0" $ length Nil `shouldBe` 0
    it "length 1" $ length (Cons 1 Nil) `shouldBe` 1

  -- Property test examples.
  describe "Integer and Nat" $ do 
    prop "S is inc" $ (\n -> (intToNat . natToInt) n === n)

{- -- This is comment outed intentionally because this require some implementation in Recursive.hs
  describe "length and lengthNat is equivalent" $ do
    prop "for any List xs, length xs = natToInt (lengthNat xs)"
      $ (\(xs :: List Int) -> length xs === natToInt (lengthNat xs) )

  describe "Arithmetic" $ do
    prop "add and addNat" $ 
      (\(x :: Nat) -> \(y ::Nat) -> natToInt(addNat x y) === add (natToInt x) (natToInt y))
    prop "mul and mulNat" $
      (\(x :: Nat) -> \(y ::Nat) -> natToInt(mulNat x y) === mul (natToInt x) (natToInt y))
    -- Is there a way to generalize the above two property test?
-}


-- only defined for n >= 0
intToNat :: Int -> Nat
intToNat 0     = Z
intToNat n     = S (intToNat (n -1))

natToInt :: Nat -> Int
natToInt Z     = 0
natToInt (S n) = (+1) (natToInt n)

instance Eq Nat where
  Z == Z = True
  (S m) == (S n) = m == n


applyN :: Integral a => (b -> b) -> b -> a -> b
applyN _ k 0 = k
applyN f x n = applyN f (f x) (n - 1)

-- The following two instances are  bit advanced material that generates arbitrary Nat and List.
-- Arbitrary is a type clas that provides randomized values for its instances.
-- Tes.QuickCheck.Arbitrary module provides instances of many important types.

-- But here, Nat and List are implemented by ourself for this course, we need to provide
-- instance for them.
instance Arbitrary Nat where
  arbitrary = arbitrarySizedNatural >>= \n -> return (applyN S Z n)

instance Arbitrary1 List where
  liftArbitrary = listOf'
instance Arbitrary a => Arbitrary (List a) where
  arbitrary = arbitrary1

listOf' :: Gen a -> Gen (List a)
listOf' gen = do
  n <- getSize
  k <- choose(0, trace(show n) n)
  list k Nil gen -- starting point
  where
    list 0 xs gen = return xs
    list n xs gen = do
      x <- gen
      list (n-1) (Cons x xs) gen



