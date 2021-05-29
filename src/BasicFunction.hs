module BasicFunction where

-- Only listed types and functions are imported
import Prelude (
  Bool(..), Int, Char, String, Num(..),
  -- Functions for List
  length, head, tail, (++), reverse, concat,
  map, filter,
  const, id,
  (==)
  )


-- Type of function
-- CHECK the type of length, head, tail, (++), map, filter, reverse, concat, concatMap in the REPL.
-- Remember, you can open the repl by running "cabal repl" in the projet's root directory.

{-
In general, the type of a function is (a -> b) where a and b are any type.
a and b can even be functions.
(The idea is defined recursively or inductively.)
Int -> Int
String -> Int
String -> String
String -> Char
The above are all types of functions.

String -> String -> String is too.
It is interpreted as String -> (String -> String) not (String -> String) -> String.

The former is a function whose input is a String and returns a function from String to String.
On the other hand, the latter is a function whose input is a function from String to String, and its output is a String.

Even more
String -> (String -> Bool) -> String
is also a function type.

Can you describe the inputs and outputs to this function?
-}


a0, a1, a2, a3 :: Int
a0 = length []              -- 0
a1 = length [1,2,3]         -- 3
a2 = length ['a','b','c']   -- 3
a3 = length "abc"           -- 3 (Remember, String is just an alias of [Char])


-- The functions "head" and "tail" are considered to be "unsafe" functions because
-- they are "partial functions", not "total functions".
-- A "total function" is a function which returns value for all inputs.
-- A "partial function" is a function which is not total; the return value for some inputs are not defined.

--b0 = head []    -- This is an error because nil has no head element. This is the reason head is a partial function.
b1 = head [1,2,3]
b2 = head ['a','b','c']
b3 = head "abc"

--c0 = tail []    -- This is an error because nil has no tail element. This is the reason tail is a partial function.
c1 = tail [1,2,3]
c2 = tail ['a','b','c']
c3 = tail "abc"

-- append lists
d1, d2, d3, d4, d5 :: [Int]
d1 = [] ++ []
d2 = [] ++ [1]
d3 = [1] ++ [2]
d4 = [1,2,3] ++ [4,5]
d5 = [1,2,3] ++ [4,5] ++ [6] ++ [7,8,9]

-- CHECK on repl
{-
:i (++)

--(++) :: [a] -> [a] -> [a] 	-- Defined in ‘GHC.Base’
--infixr 5 ++
-}
{-
infixr 5 ++  says function (++) is infix function associated to right with priority 5.
[1,2,3] ++ [4,5] ++ [6] ++ [7,8,9] is
[1,2,3] ++ ([4,5] ++ ([6] ++ [7,8,9]))
not
((([1,2,3] ++ [4,5]) ++ [6]) ++ [7,8,9])
-}


-- (++) is normaly called append
e1, e2, e3, e4 :: String -- or [Char]
e1 = [] ++ []                    -- []
e2 = [] ++ ['a']                 -- ['a']
e3 = ['a'] ++ ['b']              -- ['a','b']
e4 = ['a','b','c'] ++ ['d','e']  -- ['a','b','c','d','e']
e4' = "abc" ++ ['d','e']         -- same as e4
e4'' = "abc" ++ "de"             -- same as e4


-- reverse list
f1, f2, f3, f4 :: [Int]
f1 = reverse []                         -- []
f2 = reverse [1]                        -- [1]
f3 = reverse [1, 2]                     -- [2,1]
f4 = reverse [1,2,3]                    -- [3,2,1]


-- List of List of Integer
g0, g1, g2, g3, g4, g5 :: [[Int]]
g0 = []
g1 = [[]]
g2 = [[], []]
g3 = [[], [1]]
g4 = [[1,2,3]]
g5 = [[1,2,3], [], [1, 2, 3]]


-- concat
g0', g1', g2', g3', g4', g5' :: [Int] -- one level down from [[Int]]
g0' = concat []
g1' = concat [[]]
g2' = concat [[], []]
g3' = concat [[], [1]]
g4' = concat [[1,2,3]]
g5' = concat [[1,2,3], [], [1, 2, 3]]


-- Basic function definitions for map
h1, h1', h2, h2', h2'' :: Int -> Int
h1 x    = 1            -- always return 1
h1'     = const 1      -- same h1
h2 x    = x + 1        -- increment by 1
h2'     = \x -> x + 1  -- lambda
h2'' x  = (+1) x       -- section
h2'''   = (+1)         -- \eta converted version of h2''



-- Basic function definitions for filter
i1, i1', i2, i2', i3, i3' :: Int -> Bool
i1 i   = True         -- always return True
i1'    = const True   -- same as i1 const is defined in Prelude
i2 i   = False        -- always return False
i2'    = const False  -- same as i2
i3   i = i == 0       --
i3'  i = if i == 0    -- if then else returns value
           then True
           else False
i3'' i = case i of -- same as h6
         0 -> True
         _ -> False

-- map
j1, j1', j2, j2' :: [Int]
j1  = map h1 []
j1' = map h1 [1,2,3,4]
j2  = map h2 []
j2' = map h2 [1,2,3,4]
-- TRY: h1' etc


-- filter
k1, k2 :: [Int]
k1  = filter i1 []
k1' = filter i1 [0,1,2,3]
k2  = filter i2 []
k2' = filter i2 [0,1,2,3]
k3  = filter i3 []
k3' = filter i3 [0,1,2,3]
-- TRY: i2', etc.

-- concatMap
-- concatMap is a compositon of concat and map as expected
-- Type of concatMap is declared like this you can consider t as List in our setting at this moment.
-- concatMap :: Foldable t => (a -> [b]) -> t a -> [b]
concatMap' :: (a -> [b]) -> [a] -> [b]
concatMap' f xs = concat (map f xs)
-- Note that type of f is a -> [b] not a -> b, f should generate List of type b.
-- (map f xs) generates List of List, concat crash the outer List.
