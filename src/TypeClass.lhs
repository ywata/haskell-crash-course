
> module TypeClass where
> import Prelude (String, Integer, Num(..), (++), Maybe(..), Char, map, concatMap,  id, mod, (++))

I am considering covering this as part of the crash course.

Type class sounds like a class in Java but it is actually not.
It is much similar to interface in Java. Do not confuse it.

As type class is like an interface, it will be easier for you to consider the purpose of the type class.
Especially in the case of Monad, it sounds mysterious and some people (including me) try to understand the
meaning of Monad but feel that it is useless for programmers because we are not mathematicians.

I recommend for you to understand Monad as a interface with several methods (with some property).
That will be enough to get started programming Haskell code.

To define a type class (or interface in Java) you use the class keyword.
class is a attribute of a type. To provide the implementation of a class (or interface in Java)
in the context of a specific data type using the instance keyword.
This is the equivalent of saying that the class implements the interface in Java.
The big difference between Haskell and Java, however, is that you don't define this in data declaration; you define it separately.

In the following code we are declaring the following:
The (Show a) class says that the object has a function (show) that returns a String.
(In Java parlance, this means that an object that implements Show must implement a function show() that returns a String)
Therefore, if a data type `a' has the Show property, you can use show show method with the value `a'.

Purpose of our Show class:
- to preset a representation of the value of a class (think: Java's toString() function)

An example property of the Show class:
- if the class provides the Read interface, read . show = id
That is, (show) followed by (read) is equivalent to the identity function.
We are saying that if we (show) something and (read) it back, the result is the same as what we started with.
You could perhaps think of it in Java as `A newA = A.parse(a.toString())`.

Let's go with some examples:

We will use the Bool ADT from previous chapters for a simple example of how to implement Show

> data Bool = False | True

Again, Show takes `a' and returns a String

> class Show a where
>   show :: a -> String

For Bool, let's return "False" and "True" for False and True, respectively
You instanciate (implement) the Show class for Bool in the following way:

> instance Show Bool where
>   show False = "False"
>   show True = "True"

Prelude defines several type classes, including:
Eq, Ord, Num, Monoid, Functor, Applicative, Monad

Note: The definitions used in explanations here are not the exact same as the definitions in Prelude

Eq is used to decide equality of value of data type `a'.

Purpose of the Eq class:
- to decide equality of a value.
Property of the Eq class:
- The author is not sure.

> class Eq a where
>   (==) :: a -> a -> Bool -- Eq provides a way to decide equality between values of a SAME type.

That is, to implement Eq on a type we should implement a function (==) that takes two values of type `a' and returns a Bool

Purpose of the Ord class:
- to compare the order (as in sort order) of two values.
Property of the Ord class:
- The class must have an instance of Eq.

> data Ordering = LT | EQ | GT
> class (Eq a) => Ord a where  -- The `(Eq a) =>` syntax says that in order to be part of the Ord class,
>                              -- a must already be a part of the Eq class
>   (<) :: a -> a -> Ordering  -- Ord provides the function (<) which takes two values of type `a' and returns either
>                              -- LT (less than), EQ (equal), or GT (greater than)


Semigroup is an abstraction of Int, List, etc. Many structures can be a Semigroup.
The most important method defined in Semigroup is (<>). (<>) is an operator for Semigroup.
(<>) should satisfy a specific property to be a Semigroup.

Purpose of Semigroup class:
- to provide a binary operation on a type (a binary operation takes two inputs)
Property of Semigroup class:
- The defined operator is associative.

> class Semigroup a where
>   -- infixr 6 : right associative
>   (<>) :: a -> a -> a -- binary operator

For all l, m and l of type a,
(l <> m) <> n == l <> (m <> n) must hold. (This satisfies "The defined operator is associative")

One of the easiest examples of a Semigroup is Integer. What operations can be (<>) in Integer?
Remember, that it must take two inputs of Integer and return an Integer, and it also must be associative.

For all l, m and n of Integer type, two obvious operations are addition and multiplication:
(l + m) + n == l + (m + n)
(l * m) * n == l * (m * n)
In both cases, associativity holds.
So Integer can be Semigroup in at least two senses.

To make a type of an instance of the type class, you can define:

> instance Semigroup Integer where
>   (<>) m n = m + n
> -- (<>) = (+)

This makes the following equivalent:

> i1, i1' :: Integer
> i1  = 1 + 2
> i1' = 1 <> 2

As mentioned previously, (*) can also be used as (<>).
Though Integer can be a Semigroup in multiplication, you cannot instanciate like that since we already intanciated it with (+).

Since only one instance for a type class is allowed, the below definition will cause a compilation error:
instance Semigroup Integer where
  (<>) = (*)

There is a workaround for this. It requires wrapping the original type using newtype.

> newtype Integer' = I Integer
> instance Num Integer' where
>   I a + I b = I (a + b)
>   I a * I b = I (a * b)
>   abs (I a) = I (abs a)
>   signum (I a) = I (signum a)
>   fromInteger a = I a
>   negate (I a) = I (negate a)
>
> instance Semigroup Integer' where
>   (I m) <> (I n) = I (m * n)

In the above instanciation, m and n is Integer and (I m) (I n) and I(m * n) are Integer'.

Just a bit annoying...

> j1 :: Integer -- the type is Integer not Integer'
> j1 = 3 * 4
> j1' :: Integer'
> j1' = I 3 <> I 4


You can also think of List as a Semigroup because the (++) operator (list concatenation):
* is a binary operator that returns a result of the same type (takes two lists as input and returns a list)
* is associative

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
- to provide a binary operation and a neutral element that when used as an input to the binary operation, results in the output being equal to the other input
Property of Monid class:
- The defined operator is associative and the neutral element is neutral to the operation.

> class (Semigroup a) => Monoid a where -- A Monoid must also be a Semigroup

              +-------- A VALUE of type a
              |
              v

>   mempty :: a            -- It looks like mempty is a function, but it's a neutral value in Monoid.
>   mappend :: a -> a -> a -- This is (<>) from the Semigroup

As the name of the methods of Monoid suggests, it models String.
mempty is the empty String "" and mappend is append or concatenation of String.


Behind the Monoid class, we have to assure that:
mappend mempty m      == m                          -- mempty is neutral (when applying mappend to m and mempty, the result is m)
mappend m      mempty == m                          -- mempty can be in either position
mappend l (mappend m n) == mappend (mappend l m) n  -- this comes from Semigroup's (<>)

You saw:
class (Semigroup a) => Monoid a where
This means, if type a is a Monoid, a is also a Semigroup (but the inverse is not true).
i.e., even if a is a Semigroup, it is normally not Monoid. This is what => means.

As mentioned previously, String is an instance of Monoid.

> instance Monoid [a] where
>   mempty = []
>   mappend = (++) -- As Monoid is a Semigroup, you can also use (<>).

Another example is Int
Integer can be a Monoid with respect to addition and also multiplication.
Consider how to make Int a Monoid for (+) and for (*).
You need newtype to do both, but first start with either one of the operations.
Make Integer a Monoid with respect to addion, and Integer' a Monoid with respect to multiplication.

Let's see how to do that:

> instance Monoid Integer where
>   mempty = 0    -- Adding 0 to an integer results in the same value: 3 + 0 = 3, or 0 + 3 = 3
>   mappend = (+) -- As Monoid is also a Semigroup, you could just use (<>) here.
>
> instance Monoid Integer' where
>   mempty = I 1  -- Multiplying an integer by 1 results in the same value: 3 * 1 = 3, and 1 * 3 = 3
>   mappend = (*) -- As Monoid is also a Semigroup, you could just use (<>) here.

The definitions before => are called "Constraints"

        +------------- Constraints for a (The type a must be a C1)
        |      +------ More Constraints for a (The type a must also be a C2)
        |      |            +--------- Properties of AClass is common for all type a.
        |      |           |      +---- Some type
        |      |           |      |
        |      |           |      |
        v      v           v      v

class (C1   a, C2    a) => AClass a where
  method :: a -> a

In Monoid's case, Semigroup is the only constraint.


Functor is relatively easier to understand by thinking of it as a container.
fmap applies transformation to the contents inside the container.

Purpose of Functor class:
- apply a function to the contents of some structure
Property of Functor class:
- Functor laws
  fmap id = id                     -- it has an identity function that returns an output that is the same as the input
  fmap (f . g) = fmap f . fmap g   -- the functions can be composed: "composition"


> class Functor f where
>   fmap :: (a -> b) -> f a -> f b  -- Apply the function a -> b to the contents (a) of (f a) and return the result (b) wrapped in f as (f b)
>
> instance Functor Maybe where      -- Maybe is an easy example of a where you might use a Functor
>   fmap _ Nothing = Nothing        -- For Maybe, in the case of an input of Nothing, we can ignore the function provided to fmap and just return Nothing
>   fmap f (Just a) = Just (f a)    -- Think of `a' inside (Maybe a) as the content `a' in the container `Maybe'.
>                                   -- We pull `a' out of the `Just' container, apply f to it, and return it repackaged back into `Just'.
>
> instance Functor [] where         -- There is already a function defined for lists that can be used for a Functor in [], it is the (map) function
> -- fmap f xs = map f xs           -- This is the long-hand way of writing it: fmap of f over some list is equal to the map of f over that list
> -- fmap f    = map f
>    fmap      = map                -- The above can be Eta-reduced to just this
> m1  = fmap id [1,2,3]
> m1' = map  id [1,2,3]


Purpose of Applicative class:
- apply a function in a structure multiple times
Property of Applicative class:
- Applicative laws
  pure id <*> v              = v                 -- identity
  pure (.) <*> u <*> v <*> w = u <*> (v <*> w)   -- composition
  pure f <*> pure x          = pure (f x)        --
  u <*> pure y               = pure ($ y) <*> u  -- 

> class (Functor f) => Applicative f where
>   pure :: a -> f a                  -- lift value(including function)
>   (<*>) :: f (a -> b) -> f a -> f b
>   (<$>) ::   (a -> b) -> f a -> f b
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
> fct1 = fmap (\x y -> x + y) (Just 1)        -- structure is changed. 

(<*>) :: Maybe (a -> b) -> Maybe a -> Maybe b

> apl1 :: Num a => Maybe (a -> a)           
> apl1 = (pure (\x y -> x + y)) <*> (Just 1)  -- structure is preserved. Both arguments are Maybe.
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
- Monad class provide a way to encapsulate computation.

Property of Monad class:
 Monadic laws
 return a   >>= h          = h a              -- unit
 m          >>= return     = m                -- unit
 (m >>= g)  >>= h          = m >>= (g >>= h)  -- composition of monad by >>= is associative.

> class (Applicative m) => Monad m where
>   return :: a -> m a -- pure
>   (>>=) :: m a -> (a -> m b) -> m b

             m  >>=  f :: m b
             ^       ^    ^
             |       |    |
             |       |    +---------- type of m >>= f.
             |       +-------- f accepts a value of type a and returns m b
             +------ A Monad with type m a

If we have (>>=) defined for m, sequencing or composition of functions
(f::a -> m b, g::b -> m c and  h ::c -> m d)
is possible starting from n :: m a with:

n >>= f >>= g >>= h

If we did not have associativity of composition of >>=, we have to write above expression by one of
n >>= ((f >>= g) >>= h) or
n >>= (f >>= (g >>= h))

We had to distinguish them, order of composition matters,
n >>= ((f >>= g) >>= h) and n >>= (f >>= (g >>= h)) could be different.
The law just tells us we do not have to care about it.

Going back to Functor, no associativity law is mentioned. This is because
function composition is associative in the begginig, it is satisfied.

(fmap f . fmap g) . fmap h = fmap (f . g) . fmap h
                           = fmap ((f . g) . h)   <-- This is associativity of function 
                           = fmap (f . (g . h))   <-- composition.
                           = fmap f . fmap (g . h)
                           = fmap f . (fmap g . fmap h)


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






