module AbstractDataType where

import Prelude (
  Int, String, Double, Num(..)
  , undefined
  -- Functions for List
  , id
  
  )

data ISPair= Pair Int String -- ISPair is type constructor and Pair is data constructor
a1, a2 :: ISPair
a1 = Pair 0 ""
a2 = Pair undefined "a" -- You do not normally care about undeifned value.
a3 = Pair 100 undefined -- You do not normally care about undeifned value.

data DPair = DPair Double Double -- Type constructor and data constructor can be same name.

-- Actually, Prelude has generic predefined version of Pair but without explicit name.
a4 = (100, "a")         -- It is essentially same as a2, right?

-- In Haskell, because Bool is not a primitive type,
-- You can define Bool,  if you do not import Bool.
data Bool = False | True  -- Bool is type constructor and True and False are data constructor
b1, b2, b3 :: Bool
b1 = False
b2 = True
b3 = undefined -- You do not normally care about undeifned value.


-- Maybe is Optional type in Java. It requires one type to be a type.
data Maybe a = Nothing | Just a -- Maybe is a type constructor and Nothing and Just are data constructors.
{-You cannot implement this type in Java.-}
c1, c2, c3, c4 :: Maybe Bool
c1 = Nothing     -- You can distinguish Nothing and (Just False)
c2 = Just True   -- Just contains a value of Bool in this case.
c3 = Just False
c4 = undefined   -- You do not normally care about undeifned value.


-- Examples of ADT
-- Modeling studant record.
data Major = Physics | Mathematics | ComputerScience | History
data Student = Student{
  name            :: String,
  birthYear       :: Int,
  major           :: Major,
  secondMajor     :: Maybe Major -- Second major is optional
  }
data Student' = Student'{
  name'           :: String,
  birthYear'      :: Int,
  major'          :: Major,
  secondMajor'    :: Major       -- Second major is compulsory
  }


alice, bob :: Student
alice = Student "Alice" 1900 Physics Nothing
bob = Student{
  name = "Bob"
  , secondMajor = Just History
  , major = Physics
  , birthYear = 1901
  }

-- Field name is a function. name :: Student -> String
nameBob  = name bob
majorBob = major bob
alice' = alice{secondMajor = Just ComputerScience}

-- Function using ADT.

-- Functions defined in this part of this file are not same defined in Prelude.
-- This is intended to show capability of Haskell.
not :: Bool -> Bool
not False = True
not True  = False

(&&) :: Bool -> Bool -> Bool
(&&) True  True  = True
(&&) _     False = False
(&&) False _     = False

(||) :: Bool -> Bool -> Bool
False || False = False
_     || _     = True


-- TRY to use the functions above with True, False and undefined value of type Bool



-- maybe convert a value of (Maybe a) in two way.
-- If Nothing, fixed value of type b (or default value) is returned
-- If (Just a),  convert a value of type a with a function
maybe :: b -> (a -> b) -> Maybe a -> b
maybe defaultValue function Nothing      = defaultValue -- function is not referenced it can be _
maybe defaultValue function (Just value) = function value -- Extracting value from (Just value) Nice!

d1, d2 :: String
d1 = maybe "" id Nothing
d2 = maybe "" id (Just "abc")

d3, d4, d5 :: Int
d3 = maybe 0 (*2)          Nothing
d4 = maybe 0 (\x -> 2 * x) Nothing
d5 = maybe 0 (*2)          (Just 3)


