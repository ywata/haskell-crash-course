module Recursive where

import Prelude (
  Int, Bool
  , Num(..)
  , Maybe(..)
  , otherwise
  , undefined
  , (<=)
               )
-- Haskell can define recursive type and can manipulate data with recursive function

implement = undefined

data List a = Nil | Cons a (List a) -- Theses are essentially correspond to [] and [a]
-- List a appears in Cons case. AST can express resursive structure.


-- You normally need recursive function to manipulate recursive data.
a0 :: a -> List a -> List a
a0 v vs = Cons v vs

length :: List a -> Int
--      +--------------------+
--      |                    |
--      v                    v
length Nil                 = 0
length (Cons _         xs) = 1 + length xs
--           ^         ^     ^           ^
--           |         |     |           |
--           +----------------           |
--                     |                 |
--                     +-----------------
-- Nil  <--> 0
-- Cons <--> 1 +

-- head
head :: List a -> a
head Nil = undefined -- you cannot define head in a generic way
head (Cons h _) = h

-- safeHead
safeHead :: List a -> Maybe a
safeHead Nil = Nothing
safeHead (Cons h _) = Just h

-- tail
tail :: List a -> List a
tail Nil = undefined
tail (Cons _ ts) = ts

-- safeTail;
-- IMPLEMENT : safeTail
safeTail :: List a -> Maybe (List a)
safeTail Nil = Nothing
safeTail (Cons h _) = implement


-- (++)
(++) :: List a -> List a -> List a
(++) Nil xs                  = xs
(++) xs  Nil                 = xs
-- Destruct left cons cell and recursively call (++) inside tail.
--         +----------------
--         |               |
--         v               v
(++) (Cons x xs) rs = Cons x (xs ++ rs)
--           ^   ^            ^     ^
--           |   |            |     |
--           +----------------+     |
--               |                  |
--               +------------------+

-- IMPLEMENT map
-- map
map :: (a -> b) -> List a -> List b
--                 ^^^^^^
--                 List is ADT.
--                 ADT is generally constructed with possibly multiple cases.
--                 In this case Nil and Cons
--                 It means, you need at least two cases if the function is trivial.
map f Nil         = Nil      -- If no data is supplied, only yuo can return is Nil.
map f (Cons x xs) = implement

-- IMPLEMENT filter
filter :: (a -> Bool) -> List a -> List b
filter p Nil         = implement
-- if p x is True, add x to the result
-- if p x is False, ignore x from result.
filter p (Cons x xs) = if p x then implement else implement


-- Wiered map
-- wieredMap:: (a -> b) -> List a -> List b
-- wieredMap returns Nil if the length of List is less than or equal to 2
wiredMap :: (a -> b) -> List a -> List b
--                      ^^^^^^
--                 List is ADT.
--                 ADT is generally constructed with possibly multiple cases.
--                 In this case Nil and Cons
--                 It means, you need at least two cases if the function is trivial.
--                 It does not mean two cases are enough for all purpose.
wiredMap f Nil                   = implement
wiredMap f (Cons x Nil)          = Nil -- Note pattern match works like this.
wiredMap f (Cons x (Cons y Nil)) = Nil -- Arbitrary nesting can be pattern matched.
wiredMap f _                     = implement


-- You can implement wiredMap using case syntax
wiredMap' :: (a -> b) -> List a -> List b
wiredMap' f xs = case xs of
                   Nil                         -> Nil
                   Cons _ (Cons _ Nil)         -> Nil
                   Cons _ (Cons _ (Cons _ Nil)) -> Nil

-- You might think you can implement wiredMap with if then else.
-- Yes, it is but it requires extra stuff and will be discussed later.

                                                   
-- You can implement wiredMap using guard syntax. This require length function.
wiredMap''' :: (a -> b) -> List a -> List b
wiredMap''' f xs
  | length xs <= 2 = Nil
  -- otherwise is just True.
  | otherwise      = implement
                              