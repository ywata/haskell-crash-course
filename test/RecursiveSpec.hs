module RecursiveSpec where

import Prelude (($))
import Recursive

import Test.Hspec

spec :: Spec
spec = do
  describe "length test" $ do
    it "length 0" $ length Nil `shouldBe` 0
    it "length 1" $ length (Cons 1 Nil) `shouldBe` 1


