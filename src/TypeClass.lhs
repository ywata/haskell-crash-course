
> module TypeClass where
> import Prelude (String, Integer, Num((+), (*)))

I wonder I cover this as crash cource.

Type class sounds like a class in Java but it actually not.
It is much similar to interface in Java. Do not confuse it.

To define class (or interface in Java) you use class keyword.
class is a attribute of type. To provide implementation of a class (or interface in Java)
you have to instanciate class to the data type.

The meaning of the below code is
If a data type `a' has Show property, you can use show method associated to `a'.
You can show the type.

> class Show a where
>   show :: a -> String
>  
> data Bool = False | True

You have to instanciate Show class for Bool in the following way.

> instance Show Bool where
>   show False = "False"
>   show True = "True"

Prelude defines several type classes it includes:
Eq, Ord, Num, Monoid, Functor, Applicative,
Note: The explanations here are not exact same as the definition in Prelude to show
important concept.

Eq is used to decide equality of value of data type `a'.

> class Eq a where
>   (==) :: a -> a -> Bool -- Eq provides a way to decide equality between values of a SAME type.

  
Ord is used to decide order of value.

> data Ordering = LT | EQ | GT
> class (Eq a) => Ord a where  -- Ord requires a to be Eq. To define Ord a, you need a tobe Eq a.
>   (<) :: a -> a -> Ordering -- Ord provides


Semigroup is an abstraction of Int, List, etc. Many structure can be Semigroup.
The most important method defined in Semigroup is (<>). (<>) is an operator for Semigroup.
(<>) should satisfy a property to be Semigroup.


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
>-- (<>) = +

i1, i1' :: Integer
i1  = 1 + 2
i1' = 1 <> 2

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

> j1 :: Integer'
> j1 = I 3 <> I 4


> class (Semigroup a) => Monoid a where
 
              +-------- A VALUE of type a
              |
              v

>   mempty :: a            -- mempty is a VALUE not operator and has no correspondance in Semigroup
>   mappend :: a -> a -> a -- = (<>)
>   mconcat :: [a] -> a    -- = sconcat

Behind the Monoid class, we have to assure
mappend mempty m      == m
mappend m      mempty == m
mappend l (mappend m n) == mappend (mappend l m) n 


class (Semigroup a) => Monoid a where
This means, if a is Monoid, a is also Semigroup but converse is not hold.
I.e, even if a is Smigroup, it is normally not Monoid. This is what => means.
Int can be Monoid with respect to addition and multiplication.
How can we make Int as Monoid for (+) and for (*)?
You need newtype for this.

Functor

> class Functor f where
>   fmap :: (a -> b) -> f a -> f b

> class (Functor f) => Applicative f where
>   pure :: a -> f a
>   (<*>) :: f (a -> b) -> f a -> f b

I'm wondering what I show in this part.
Especially, explainig Functor Applicative and Monad in this section affects
how I show IO. It is possible to show IO without such information and
presenting abstract information may harm understanding IO.

Another consideration is even if I do not mention Functor/Applicative/Monad,
there are many important type class defined in Haskell.
Those includes:
Read, Show, Eq, Ord, Enum and Monoid.
