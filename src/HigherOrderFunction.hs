module HigherOrderFunction where

implement = undefined

{-
Higher order function is a function that inputs function as an input or that outputs function.
-}

-- Though I belive the above is the definition of higher order function but this is a
-- bit vague in Haskell, because:

append_strings :: String -> String -> String
append_strings x y = x ++ y

-- As we discussed before, the type of append_strings is String -> (String -> String)
-- It means append_string is a function from String to (String -> String). The implementation is:
append_strings' :: String -> (String -> String)
append_strings' x = \y -> x ++ y

-- Even more,
append_strings'' :: (String -> (String -> String))
append_strings'' = \x -> \y -> x ++ y



-- Function as input:
-- We already know filter, map and concatMap has function input.
-- map ::       (a -> b)    -> [a] -> [b]  as function of two arguments
-- filter ::    (a -> Bool) -> [a] -> [a]  as function of two arguments
-- concatMap :: (a -> [b])  -> [a] -> [b]  as function of two arguments

-- Function as output:
-- We also consider them as output function because:
-- map ::       (a -> b)    -> ([a] -> [b]) as function of one argument
-- filter ::    (a -> Bool) -> ([a] -> [a]) as function of one argument
-- concatMap :: (a -> [b])  -> ([a] -> [b]) as function of one argument

-- Even though we can consider them as HOF as output, the most important idea is about the first
-- argument. Accepting function as argument can make the function generic,
-- if you change the argument function, you can change the behaviour.


-- Some of HOF is essentially HOF in output.
ex1 :: String -> [String -> String]
ex1 = undefined

-- You cannot convert ex1 as a function with multiple input.
-- Such function generats function based on input.

-- Even though HOF in output side is sometimes useful but for now,
-- we first discuss input side HOF.



-- curry and uncurry
-- In most of popular programming language, functions are defined 'uncurryed'.
-- Uncurried function which has two arguments are some thing like f(x, y).
-- Haskell can accepts such function, but normally it is defined 'curried' version.

uncurried_f :: (a, b) -> c
uncurried_f = undefined
-- its curried version is
curried_f :: a -> b -> c
curried_f = undefined

-- They are essentially the same but look different.
uf = uncurried_f (1, "b")
cf = curried_f 1 "b"


-- flip: flips arguments
flip :: (a -> b -> c) -> (b -> a -> c)
flip f x y = implement

-- flip is usefull when argument is not good for map


-- The formar accepts one tuple and the latter accepts two arguments.
-- There defined HOF which converts uncurred function to curried one. It is called curry.
curry :: ((a, b) -> c) -> (a -> b -> c)
curry f = \x y -> implement

uncurry :: (a -> b -> c) -> ((a, b) -> c)
uncurry g = \(x, y) -> implement

-- foldr1 and foldl1

-- Suppose (^) and (!) operators of type
-- (^), (!) : a -> a -> a

-- r = (a1 ^ (a2 ^ (a3 ^ a4)))
--r = foldr1 (^) [a1, a2, a3, a4]

-- l = (((a1 ! a2) ! a3) ! a4)
--l = foldl1 (!) [a1, a2, a3, a4]


-- associativity
-- (a1 + (a2 + a3))
-- ((a1 + a2) ! a3)
-- As + is associative
-- (a1 + (a2 + a3)) = ((a1 + a2) ! a3) hold.

-- (a1 + (a2 + (a3 + (a4 + a5))))
-- ((((a1 + a2) + a3) + a4) + a5)
-- applying associativity multiple times
-- (a1 + (a2 + (a3 + (a4 + a5)))) = ((((a1 + a2) + a3) + a4) + a5)

-- this means in this case (associativity hold)
-- foldl (+) [a1, a2, a3, a4] = foldr (+) [a1, a2, a3, a4] hold


-- Comparing type of foldr and foldr1
--                            +--- initial value of type b
--                            |
--                            v
-- foldr  :: (a -> b -> b) -> b -> [a] -> b
-- foldr1 :: (a -> a -> a)      -> [a] -> a
--                            ^
--                            |
--                            +---- No initial value

--  Comparing type of foldr and foldl

--                            +--- initial value of type b
--                            |
--                            v
-- foldr  :: (a -> b -> b) -> b -> [a] -> b
-- foldl  :: (b -> a -> b)    b -> [a] -> b
--                            ^
--                            |
--                            +---- Initial value of type b


-- [a1, a2,  a3,  a4, ...] b0
-- a1 ^ b0 = b1
--      a2 ^ b1 = b2
--           a3 ^ b2 = b3
--                a4 ^ b3 = b4
--
-- a4 ^ (a3 ^ (a2 ^ (a1 ^ b0))) = foldr (!) [a1, a2, a3, a4]
r  :: (a -> b -> b) -> b -> [a] -> b
r g b [] = b
r g b (x : xs) = r g (g x b) xs



--     [a1,  a2,  a3,  a4, ...] b0
-- b0 ! a1 = b1
--      b1 ! a2 = b2
--           b2 ! a3 = b3
--                b3 ! a4 = b4
-- (((b0 ! a1) ! a2) ! a3) ! a4 = foldl (!) b0 [a1, a2, a3, a4]
l  :: (b -> a -> b) -> b -> [a] -> b
l g b [] = b
l g b (x : xs) = l g (g b x) xs



-- foldr
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr = implement



-- foldl
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl = implement
