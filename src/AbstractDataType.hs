module AbstractDataType where

import Prelude (
  Int, String, Double, Num(..)
  , undefined
  -- Functions for List
  , id

  )

data ISPair = Pair Int String -- ISPair is a type constructor and Pair is data constructor
a1, a2 :: ISPair
a1 = Pair 0 ""
a2 = Pair undefined "a" -- In general, you will not use undefined values (see BasicType.hs)
a3 = Pair 100 undefined -- In general, you will not use undefined values (see BasicType.hs)
a4 = Pair 100 "a"

data DPair = DPair Double Double -- Type constructor and data constructor can use the same name

-- Actually, Prelude has a generic, predefined version of Pair but without an explicit name
-- You can use it with the syntax below:
a5 = (100, "a")         -- This is essentially same as a4, right?

-- In Haskell, because Bool is not a primitive type,
-- you can define Bool if you do not import Bool.
data Bool = False | True  -- Bool is the type constructor and True and False are data constructor
b1, b2, b3 :: Bool
b1 = False
b2 = True
b3 = undefined -- In general, you will not use undefined values (see BasicType.hs)


-- Maybe is similar to the Optional type in Java. It requires one type to be a type.
-- This concept is similar to generics in Java. (Maybe a) means a Maybe that may hold a value of type a (whatever you specify for a)
-- Haskell typically uses a for generic types. This is in contrast to Java which uses T.
data Maybe a = Nothing | Just a -- Maybe is a type constructor and Nothing and Just are data constructors.
{-You cannot implement this type in Java.-}
c1, c2, c3, c4 :: Maybe Bool
c2 = Just True   -- Just contains a value of True in this case
c3 = Just False  -- Just contains a value of False in this case
c1 = Nothing     -- Nothing is the data constructor that says it holds nothing;
                 -- you can use this distinguish between Nothing and (Just False)
c4 = undefined   -- You can also specify undefined, though in general, you will not use undefined values (see BasicType.hs)


-- Examples of ADT (Abstract Data Type)
-- Let's model a record to represent a Student.
-- They can major in one of the following topics:
data Major = Physics | Mathematics | ComputerScience | History

-- A Student has a name, a birth year, a major, and SOME students have a second major.
data Student = Student{
  name            :: String,
  birthYear       :: Int,
  major           :: Major,
  secondMajor     :: Maybe Major -- The second major is optional; we use Maybe to show that
  }

-- At another educational establishment, students must take two majors; the second major is not optional:
data Student' = Student'{
  name'           :: String,
  birthYear'      :: Int,
  major'          :: Major,
  secondMajor'    :: Major       -- For this type of student, the second major is compulsory; we aren't using Maybe here
  }

-- Let's create two students. We'll use two different syntaxes for each example.
alice, bob :: Student

-- We'll make alice using the simple syntax
-- The values are assigned in the order that they are declared in the data structure, so the order is important
alice = Student "Alice" 1900 Physics Nothing

-- For bob, we'll use the more explicit format
-- Note that here we don't have to be concerned about the order of each piece of data
bob = Student{
  name = "Bob"
  , secondMajor = Just History
  , major = Physics
  , birthYear = 1901
  }

-- Declaring fields on data creates an implicit function
-- The field name is the name of the function, and it can be applied to the data type
-- That is, name is a function that takes a Student and returns a String, ie:
-- name :: Student -> String
nameBob  = name bob
-- Similary, the function major is implicitly created as
-- major :: Student -> Major
majorBob = major bob

-- You can also make copies of data whilst making changes using the following syntax
-- Note that this does not change the value of the original alice
alice' = alice{secondMajor = Just ComputerScience}


-- Functions that use ADT (Abstract Data Type)
-- Note that the functions defined in this part of the file are not the same defined in Prelude
-- They are intended to show capability of Haskell

-- not returns the opposite value for the Bool (as you might expect)
not :: Bool -> Bool
not False = True
not True  = False

-- Functions that are written purely with symbols are surrounded by brackets. This is the AND function:
(&&) :: Bool -> Bool -> Bool
(&&) True  True  = True     -- If both inputs are True, return True
(&&) _     False = False    -- If the last input is False (ignoring the first), return False
(&&) False _     = False    -- If the first input is False (ignoring the second), return False
-- Note that you could replace the bottom two lines with the following:
-- (&&) _     _     = False

-- This is the OR function. For OR, if both of the inputs are False, then return False. For all other inputs, we return True:
(||) :: Bool -> Bool -> Bool
False || False = False
_     || _     = True


-- TRY to use the functions above with True, False and undefined value of type Bool


{-

Now let's try something a little more advanced:

We declared (Maybe a) earlier. Recall that it may or may not hold a value of type a.

Let's say that we have a function (f) that takes a value of type a and returns a value of type b.
That is, f :: a -> b
This function (f), however, doesn't understand (Maybe a), so it won't know what to do with Nothing.

Let's make a new function (maybe) that we can use to wrap it to help it support Maybe.

Maybe has two states: Nothing, or Just a.
Our first function (f) understands a, so we can apply it to a (after extracting it from (Just a)),
but we cannot apply it to Nothing.
Let's have the function (maybe) return a default value when Nothing.

Our function (maybe) will therefore need multiple inputs:
* The default value when Nothing
* The function we will apply to the a in the case of (Just a)
* And finally, the input value of type (Maybe a)

The type will look like the below. See if you can figure out how to implement it.
It's like a puzzle!

-}
maybe :: b -> (a -> b) -> Maybe a -> b



{-

No cheating!





















No cheating!





















No cheating!

-}



-- Even though a and b are any type, maybe is still implementable:
maybe defaultValue function Nothing      = defaultValue   -- In the case of Nothing, function is not referenced so we could write it as _
maybe defaultValue function (Just value) = function value -- Extracting the value from (Just value) using pattern matching. Nice!

-- How about this?
bad :: a -> b
bad = undefined

-- Try to work out what d1 and d2 will hold
d1, d2 :: String
d1 = maybe "" id Nothing
d2 = maybe "" id (Just "abc")

-- Now, try to work out what d3, d4, and d5 will hold
d3, d4, d5 :: Int
d3 = maybe 0 (*2)          Nothing
d4 = maybe 0 (\x -> 2 * x) Nothing
d5 = maybe 0 (*2)          (Just 3)
