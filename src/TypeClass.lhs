
> module TypeClass where
> import Prelude (String, Integer, Num((+), (*)), (++), Maybe(..), Char, map, concatMap,  id, mod, (++))

I wonder I cover this as crash cource.

Type class sounds like a class in Java but it actually not.
It is much similar to interface in Java. Do not confuse it.

As type class is like interface, it will be easier for you to consider the purpose of the class.
Especially, Monad sounds like mysterious and some people (including me) try to understand the
meaning of Monad but it is useless for programer because we are not mathematician.
I recommend for you to understand Monad as a interface with several method (with some property).
That will be enough to program Haskell code in the first place.

To define class (or interface in Java) you use class keyword.
class is a attribute of type. To provide implementation of a class (or interface in Java)
you have to instanciate class to the data type.

The meaning of the below code is
If a data type `a' has Show property, you can use show method associated to `a'.
You can show the type.

Purpose of Show class:
- to preset a representation of value of a class
Property of Show class:
- if the class provides Read interface, read . show = id

> class Show a where
>   show :: a -> String
>
> data Bool = False | True

You have to instanciate Show class for Bool in the following way.

> instance Show Bool where
>   show False = "False"
>   show True = "True"

Prelude defines several type classes it includes:
Eq, Ord, Num, Monoid, Functor, Applicative, Monad

Note: The explanations here are not exact same as the definition in Prelude to show
important type classes.

Eq is used to decide equality of value of data type `a'.

Purpose of Eq class:
- to decide equality of a value.
Property of Eq class:
- The author is not sure.

> class Eq a where
>   (==) :: a -> a -> Bool -- Eq provides a way to decide equality between values of a SAME type.


Purpose of Ord class:
- to compare a order of two values.
Property of Ord class:
- The class must have an instance of Eq.

> data Ordering = LT | EQ | GT
> class (Eq a) => Ord a where  -- Ord requires a to be Eq. To define Ord a, you need a tobe Eq a.
>   (<) :: a -> a -> Ordering -- Ord provides


Semigroup is an abstraction of Int, List, etc. Many structure can be Semigroup.
The most important method defined in Semigroup is (<>). (<>) is an operator for Semigroup.
(<>) should satisfy a property to be Semigroup.

Purpose of Semigroup class:
- to provide a binary operation on a type
Property of Semigroup class:
- The defined operator is associative.

> class Semigroup a where
>   -- infixr 6 : right associative
>   (<>) :: a -> a -> a -- binary operator

For all l, m and l of type a,
(l <> m) <> n == l <> (m <> n) must be hold.

One of the easiest example of Semigroup is Integer. What operation can be (<>) in Integer?
for all l, m and l of Integer type, it is obvous
(l + m) + n == l + (m + n)
(l * m) * n == l * (m * n)
hold. So Integer can be Semigroup in at least two sense. To make a type of an instance of type class, you can define:

> instance Semigroup Integer where
>   (<>) m n = m + n
> -- (<>) = (+)

> i1, i1' :: Integer
> i1  = 1 + 2
> i1' = 1 <> 2

As mentioned, (*) can be used as (<>).
Though Integer can be Semigroup in multiplication, you cannot instanciate like that.

-- The below definition cause compilation error, since only one instance for a type class is allowed.
instance Semigroup Integer where
  (<>) = (*)

There is a workaround for this. It requires wrapping original type with newtype.

> newtype Integer' = I Integer
> instance Semigroup Integer' where
>   (I m) <> (I n) = I (m * n)

In the above instanciation, m and n is Integer and (I m) (I n) and I(m * n) are Integer'.
A bit annoying.

> j1 :: Integer -- the type is Integer not Integer'
> j1 = 3 * 4
> j1' :: Integer'
> j1' = I 3 <> I 4


You can think of List as Semigroup.

> instance Semigroup [a] where
>   (<>) = (++)
>
> l1, l1' :: [Integer]
> l1 = [1, 2, 3] ++ [4, 5]
> l1' = [1, 2, 3] <> [4, 5]
> l2, l2' :: [Char]
> l2 = ['a', 'b'] ++ ['c']
> l2' = "ab" <> "c"


Purpose of Monoid class:
- to provide a binary operation and a neutral element
Property of Monid class:
- The defined operator is associative and the neutral element is neutral to the operation.

> class (Semigroup a) => Monoid a where

              +-------- A VALUE of type a
              |
              v

>   mempty :: a            -- It looks mempty is a function but it's a neutral value in Monoid.
>   mappend :: a -> a -> a -- = (<>)

As the name of the methods of Monoid suggests, it models String.
mempty is the empty String "" and mappend is append or concatenation of String.


Behind the Monoid class, we have to assure
mappend mempty m      == m                       -- mempty is neutral
mappend m      mempty == m                       -- in this sense.

mappend l (mappend m n) == mappend (mappend l m) n  -- this comes from Semigroup's (<>)

You saw:
class (Semigroup a) => Monoid a where
This means, if type a is a Monoid, a is also Semigroup but the converse is not hold.
I.e, even if a is a Smigroup, it is normally not Monoid. This is what => means.

As mentioned, String is an instance of Monoid.

>
> instance Monoid [a] where
>   mempty = []
>   mappend = (++) -- As Monoid is a Semigroup, you can also use (<>).

Another example is Int
Integer can be Monoid with respect to addition and multiplication.
How can we make Int as Monoid for (+) and for (*)?
You need newtype for this.

Making Integer as Monoid with respect to addion and Integer' as Monoid with respect to multiplication.


> instance Monoid Integer where
>   mempty = 0
>   mappend = (+) -- As Monoid is a Semigroup, you can refer (<>).
>
> instance Monoid Integer' where
>   mempty = I 1
>   mappend = (*) -- As Monoid is a Semigroup, you can refer (<>).


        +------------- Constraints for a
        |      +------ Constraints for a
        |      |            +--------- As property of AClass is common for all type a.
        |      |           |   +---- A type                                          
        |      |           |   |
        |      |           |   |
        v      v           v   v

class (C1   a, C2    a) => AClass a where
  method :: a -> a
Monoid's case Semigroup is the only constraint.


Functor is relatively easier to understand by thinkig it as a container.
fmap apply transformation.


Purpose of Functor class:
- apply a function in a structure
Property of Functor class:
- Functor laws
  fmap id = id                     -- identity
  fmap (f . g) = fmap f . fmap g   -- composition



> class Functor f where
>   fmap :: (a -> b) -> f a -> f b
>
> instance Functor Maybe where
>   fmap _ Nothing = Nothing
>   fmap f (Just a) = Just (f a)
>
> instance Functor [] where
> -- fmap f xs = map f xs
> -- fmap f    = map f
>    fmap      = map
> m1  = fmap id [1,2,3]
> m1' = map  id [1,2,3]


Purpose of Functor class:
- apply a function in a structure multiple times
Property of Functor class:
- Applicative laws
  pure id <*> v              = v                 -- identity
  pure (.) <*> u <*> v <*> w = u <*> (v <*> w)   -- composition
  pure f <*> pure x          = pure (f x)        --
  u <*> pure y               = pure ($ y) <*> u  -- 

> class (Functor f) => Applicative f where
>   pure :: a -> f a                  -- lift value(including function)
>   (<*>) :: f (a -> b) -> f a -> f b
>   (<$>) :: (a -> b) -> f a -> f b
>   (<$>) f = (<*>) (pure f)
>
> instance Applicative Maybe where
>   pure a = Just a
>   (<*>) Nothing _         = Nothing
>   (<*>) _ Nothing         = Nothing
>   (<*>) (Just f) (Just v) = Just (f v)
>
> instance Applicative [] where
>   pure a = [a]
>   (<*>) [] xs = []
>   (<*>) (f : fs) xs = map f xs ++ (<*>) fs  xs


What is nice about Applicative as compared to Functor is an ability to sequence funtion applications.

fmap :: (a -> b) -> Maybe a -> Maybe b

> fct1 :: Num a => Maybe (a -> a)
> fct1 = fmap (\x y -> x + y) (Just 1)      -- structure is changed

(<*>) :: Maybe (a -> b) -> Maybe a -> Maybe b

> apl1 :: Num a => Maybe (a -> a)           -- structure is same after application
> apl1 = (pure (\x y -> x + y)) <*> (Just 1)
> apl2, api2', api2'', api2''' :: Num a => Maybe a                  -- You can apply again.
> apl2    = apl1                                <*> (Just 2)
> api2'   = (pure (\x y -> x + y)) <*> (Just 1) <*> (Just 2)
> api2''  = (\x y -> x + y)        <$> (Just 1) <*> (Just 2)
> api2''' = (+)                    <$> (Just 1) <*> (Just 2)


Suppose we have a function with two arguments and x :: a, y ::b.
g   ::     a    ->   b   -> c
You can call the function and use the function for Applicative f.
g          x     y ::   c
g      <$> x <*> y :: f c
pure g <*> x <*> y :: f c




Finally, we can dive into Monad.
Applicative has more capability than Functor and Monad has more capability than Applicative.
What is the capability?

Purpose of Monad class:
 Monad class provide a way to encode computation.

Property of Monad class:
 Monadic laws
 return a   >>= h          = h a              -- unit
 m          >>= return     = m                -- unit
 (m >== g)  >>= h          = m >>= (g >>= h)  -- composition of monad by >>=

> class (Applicative m) => Monad m where
>   return :: a -> m a -- pure
>   (>>=) :: m a -> (a -> m b) -> m b
>
> instance Monad Maybe where
>   return = pure
>   Just a >>= f = f a
>   Nothing >>= f = Nothing
>
> instance Monad [] where
>   return = pure
>   xs >>= f = concatMap f xs
> n1, n1', n2, n3 :: Maybe Integer
> n1  =  Just 3  >>= (\x -> return (2 * x))
> n1' = return 3 >>= (\x -> return (2 * x))
> n2  =  Nothing >>= (\x -> return (2 * x))
> n3  = return 3 >>= (\_ -> Nothing)
> n3'  = Nothing  >>= (\_ -> Nothing)


The key of the above question is the type. Though the notation is not legal Haskell but
Flipping <*> makes easier to understand the difference. As pure and return are same,
composition is the key.

                       +------- Applicative
                       |         +----------- Non applicative type
                       |         |
                       v         v
(flip <*>) :: f a  ->  f (a  ->  b)    -> f b  --- Applicative composition
(>>=)      :: m a ->     (a -> m b)    -> m b  --- Monadic composition
                       ^       ^          ^
                       |       |          |
                       |       +--------------- Monad with same type
                       +------- Second argument of (>>=) is not Monad
Applicative style

> n4' = (\x -> case x of
>                     3 -> (-1)
>                     k -> k) <$> (Just 3)

Monadic style

> n4 = Just 3 >>= (\x -> case x of
>                     3 -> return (-1)
>                     k -> return k)

Other than monadic version uses return, The above two look same. As using return suggests, other than return something is also allowed.

> n5 = Just 4 >>= (\x -> case x of
>                     3 -> return (-1)
>                     k -> Nothing)

This is impssible with Applicative but possible with Monad. This is the key of Monad.






