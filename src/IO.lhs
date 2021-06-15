
> module IO where

                                                       External world
+-------------------------------------------+            +----------+
| IO a                                      | getChar    | keyboard |
|             +------------------------+    |<===========|          |
|             | Function               |    |            +----------+
|             |                        |    |
|             |                        |    | putStr     +---------+
|             |                        |    | putChar    |keyboard |
|             +------------------------+    |===========>|         |
|                                           |            +---------+
+-------------------------------------------+
If you only use feature of Haskell mentioned in
BasicTypes, BasicFunctions and AbstracTypes, you cannot interact with outside world.
You cannot get information from keyboard nor you cannot print information on monitor.

If this is the case, you cannot do anything interesting with Haskell.
IO is mechanism which enable interaction with the external world.


-- IO type

IO is a monad, you can expect it is a Functor, Applicative and Monad.
That means, a Monad is instances of the below.

class Functor f where
  fmap :: (a -> b) -> f a -> f b

class Functor f => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b

class Applicative m => Monad m where
  return :: a -> f a -- pure
  (>>=) :: m a -> (a -> m b) -> m b

-- The description below is from https://wiki.haskell.org/Monad
fmap f fa = do
              m <- fa
              return (f m)

Haskell has a special syntax sugar
for Monad. It's called do-notation. Do notation makes bind sequence looks imperative programming.

> fmap1, fmap1' :: IO([Char])
> fmap1 = fmap (:[]) getChar
> fmap1' = do
>             input <- getChar
>             return ((:[]) input)

pure a    = do {return a}

> pure1, pure1', pure1'', pure1''' :: IO Char
> pure1 = pure 'a'
> pure1' = return 'a'
> pure1'' = do
>             pure 'a'
> pure1''' = do
>              return 'a'


f <*> fa  = do
              m <- f
              v <- fa
              return (m v)

> toStr ::IO( Char -> [Char])
> toStr = pure (:[])
> app1, app1' :: IO [Char]
> app1 = toStr <*> getChar
> app1' = do
>           m <- toStr
>           v <- getChar
>           return (m v)

m (>>=) f   = do
               a <- m
               f a

> bind1, bind1' :: IO()
> bind1 = getChar >>= putChar
>
> bind1' = do
>         input <- getChar
>         putChar input

Another important syntax sugar is let in do block.

> let1, let1' :: IO()
> let1 = do
>   let abc = map id ['a', 'b', 'c']
>       efg = map id ['e', 'f', 'g']
>   putStr "input a character:"
>   ch <- getChar
>   let v = if ch == 'a' then abc else efg
>   putStr v
>
> let1' =
>   let abc = map id ['a', 'b', 'c']
>       efg = map id ['e', 'f', 'g']
>   in
>     putStr "Input a character:" >>= \_ -> getChar
>       >>= \ch -> return (if ch == 'a' then abc else efg)
>       >>= \v -> putStr v
>       >>= \_ -> return ()
>

