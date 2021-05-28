module TypeClass where
import Prelude (String)
-- I wonder I cover this as crash cource.

-- Type class sounds like a class in Java but it actually not.
-- It is much similar to interface in Java. Do not confuse it.

-- To define class (or interface in Java) you use class keyword.
-- class is a attribute of type. To provide implementation of a class (or interface in Java)
-- you have to instanciate class to the data type.

-- The meaning of the below code is
-- If a data type `a' has Show property, you can use show method associated to `a'.
-- You can show the type.
class Show a where
  show :: a -> String
  
data Bool = False | True

-- You have to instanciate Show class for Bool in the following way.
instance Show Bool where
  show False = "False"
  show True = "True"



-- I'm wondering what I show in this part.
-- Especially, explainig Functor Applicative and Monad in this section affects
-- how I show IO. It is possible to show IO without such information and
-- presenting abstract information may harm understanding IO.

-- Another consideration is even if I do not mention Functor/Applicative/Monad,
-- there are many important type class defined in Haskell.
-- Those includes:
-- Read, Show, Eq, Ord, Enum and Monoid.
