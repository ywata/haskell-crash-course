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
b1 :: Bool        -- variable type definition
b1 = False        -- set the value

b2 :: Bool        -- variable type definition
b2 = True         -- set the value

b3 :: Bool        -- variable type definition
b3 = undefined    -- undefined value. Third possible value for Bool.


-- Integer
i1 :: Int         -- variable type definition
i1 = 1            -- value

i2 :: Int         -- variable type definition
i2 = undefined    -- set to undefined. See what this does later!

-- String
s1, s2 :: String  -- multiple variable type definition on one line
s1 = "String"     -- value
s2 = undefined    -- undefined value. What could this do?

-- Float
f1, f2 :: Float   -- type
f1 = 1 + 2        -- value!
f2 = undefined    -- You can assign undefined to any variable of any type.

-- Double
d1, d2 :: Double  -- type
d1 = 1 + 0.5      -- value
d2 = undefined    -- Let's skip this from now on. You'll see why it has limited uses in just a moment.

-- Char
c1 :: Char        -- type
c1 = 'あ'         -- Char also supports unicode characters


-- From this project's root directory, RUN repl with "cabal repl".
-- Try the commands below and look at their output.
-- If you receive an error on the first line, try "cabal v2-repl" instead.
{-

:m +BasicTypes
i1
i2
:t i1
:t i2
1 + 2

-}

-- Slightly complex types
-- Lists
li0 :: [Int]     -- List of Int -- the [] syntax is defined in Prelude
li0 = []         -- empty list or nil

li1 :: [Int]     -- type
li1 = [1]        -- list of one element

li2 :: [Int]
li2 = [1, 2]

lc0 :: [Char]    -- List of Char
lc0 = []         -- empty list

lc1 :: [Char]    -- type
lc1 = ['あ']      -- list of one element

lc2 :: [Char]
lc2 = ['a', 'b'] -- List of two Chars

-- CHECK lc2's type in the repl using ":t lc2".
-- Remember you can open the repl with the "cabal repl" command.


-- Actually, String and [Char] are exactly same...
-- String is just an alias of [Char],
-- Like this:
type String' = [Char]
{- Also notice how we put the ' at the end of the type name.
   This is perfectly legal in Haskell, and is used often.
   You will see this often. It is generally used when two or more functions
   or variables are very closely related. -}


-- RUN the following in the repl:
{-

:m +BasicTypes
:t Char
  --  error: Data constructor not in scope

:t String
  -- error: Data constructor not in scope

-}

-- You cannot get type of Types.
-- We will find out how to inspect types in the next section!
