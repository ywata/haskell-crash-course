module BasicType where

-- This is a one-line comment.

{-
This is a multi-line
comment -}

{- You can also
  {- nest
    {- multiple line comment. Yeah! -}
   -} <-- If you remove this line. You'll be get warned. Because illegal comment nest.
-}


{- The Prelude module is automatically imported,
   but in this course, we'll explicitly import things.
   Notice how you can specify which parts of a module to import.
   Here, we are importing Bool, Char, Int, etc... -}
import Prelude (Bool(..), Char, Int, String, Float, Double,
                Num(..),
                undefined)


-- Boolean
b1 :: Bool      -- type
b1 = False         -- value

b2 :: Bool      -- type
b2 = True       -- value

b3 :: Bool      -- type
b3 = undefined -- undefined value. Third possible value for Bool.


-- Integer
i1 :: Int      -- type
i1 = 1         -- value

i2 :: Int      -- type
i2 = undefined -- undefined value

-- String
s1, s2 :: String   -- type for multiple variables
s1 = "String"  -- value
s2 = undefined -- undefined value. What?

-- Float
f1, f2 :: Float    -- type
f1 = 1 + 2        -- value !
f2 = undefined -- You can assign undefined to any variable of any type.

-- Double
d1, d2 :: Double   -- type
d1 = 1 + 0.5   -- value
d2 = undefined  -- I'll skip this from now on.

-- Char
c1 :: Char      -- type
c1 = 'あ'       -- Char supports unicode


-- RUN repl with cabal repl on top of project directory and type
{-
:m +BasicTypes
i1
i2
:t i1
:t i2
1 + 2
-}

-- Slightly  complex type
-- List
li0 :: [Int]     -- List of Int defined(or loaded) in Prelude
li0 = []         -- empty list or nil

li1 :: [Int]     -- type
li1 = [1]        -- list of one element

li2 :: [Int]
li2 = [1,2]

lc0 :: [Char]    -- List of Char
lc0 = []         -- empty list

lc1 :: [Char]    -- type
lc1 = ['あ']        -- list of one element

lc2 :: [Char]
lc2 = ['a', 'b'] -- List of two Chars

-- CHECK lc2's type on repl


-- Actually String and [Char] are exactly same.
-- String is an alias of [Char] like this.
type String' = [Char] 


-- RUN repl 
{-
:m +BasicTypes
:t Char
--  error: Data constructor not in scope
:t String
-- error: Data constructor not in scope
-}
-- you cannot get type of Types












