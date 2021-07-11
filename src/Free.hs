{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Free where

import Prelude (id, otherwise, undefined, (.), Int, Eq(..), Maybe(..), String, Show(..), (++))

import Data.Functor
import Control.Applicative
import Control.Monad

{-
Free is nested data structure siimilar to [a].
The difference is Pure has value as compared to [].
-}
data Free f r = Free (f (Free f r)) | Pure r

-- It is possible to make Free a Functor orver second type parameter r.
instance (Functor f) => Functor (Free f) where
  fmap g (Pure r) = Pure (g r)
  fmap g (Free h) = Free (fmap (fmap g) h)

-- It is also possible to make Free an Applicative Functor.
-- This typechecked but I don't check Applicative law holds.
instance (Functor f) => Applicative (Free f) where
  pure = Pure
  Pure g <*> Pure v = Pure (g v)
  Pure g <*> Free v = Free (fmap (Pure g <*>) v)
  Free g <*> Pure v = Free (fmap (<*> Pure v) g)
  Free g <*> Free v = Free (fmap (<*> Free v) g)
--  Free g <*> Free v = _
--  Pure g <*> v = fmap g v
--  Free g <*> v = Free (fmap (<*> v) g)

-- Free f can be Monad.
instance (Functor f) => Monad (Free f) where
  return = Pure
  (Pure r) >>= f = f r  
  (Free x) >>= f = Free (fmap (>>= f) x)


-- Supose we have a safe box in a hotel room.
-- - You can change secret number.
-- - You can lock the safe box.
-- - You can unlock the safe box with the secret.
data Safe n v = Change   n v  -- Change secret number
                | Lock     v  -- Lock the safe
                | Unlock n v  -- Unlock the safe with number
  deriving (Show)

instance Functor (Safe n) where
  fmap f (Change n v) = Change n (f v)
  fmap f (Lock v)     = Lock     (f v)
  fmap f (Unlock n v) = Unlock n (f v)


liftF :: (Functor f) => f r -> Free f r
liftF command = Free (fmap Pure command)

-- change secret to n
change n = liftF (Change n 1)
-- lock safe box
lock     = liftF (Lock     "1")
-- unlock safe box with secret n
unlock n = liftF (Unlock n ())


-- As safebox operations become monad, you can use the operation within do notation.
-- What happens then.
safebox :: Free (Safe Int) ()
safebox = do
  change 123
  lock
  unlock 234
  unlock 123

-- The end result of the above notation is to construct nested data structure
-- of operations.
describe :: Free (Safe Int) a -> String
describe (Pure r) = "Pure"
describe (Free (Change n v)) = "Change" ++ " " ++ show n ++ " " ++  describe v
describe (Free (Lock v)) = "Lock" ++ " " ++ describe v
describe (Free (Unlock n v)) = "Unlock" ++ " " ++ show n ++ " " ++ describe v

data LockState = Open | Closed
  deriving(Show, Eq)

-- checkSafeState 
checkSafeState :: Maybe LockState   -- Initial state if known
               -> Maybe Int         -- Initial secret if known
               -> Free (Safe Int) a -- command sequence
               -> Maybe LockState   -- final state
checkSafeState state _ (Pure _) = state
checkSafeState state sec (Free (Change n v)) = checkSafeState state (Just n) v
checkSafeState state sec (Free (Lock     v)) = checkSafeState (Just Closed) sec v
checkSafeState state sec (Free (Unlock n v))
  | sec == Just n = checkSafeState (Just Open) sec v
  | otherwise     = checkSafeState state sec v


description =  describe safebox
open = checkSafeState (Just Closed) (Just 123) safebox



