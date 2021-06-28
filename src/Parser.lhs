This module shows how we can use Monad for parsing string.

> module Parser where
>
> import Data.Functor
> import Control.Applicative
> import Control.Monad
>

Super simple parser in Haskell.

First, we need to define data type which will be an instance of Functor, Applicative and Monad for Parser.
Before doing this we need to consider what isa  parser?

A parser is a function that accepts String and returns parsed result.
For example, if character parser accepts a character and if the first element of a string is
the character, it returns that charcter. Type of the function may look like this.

charParser :: Char -> String -> Char

But this is not good type for character parser because
1. If the first charcter of the second argument(String) is not the first argument,
   it is no way to know it fails to match.
2. Parser should parse consecutive charcter in String but we loose the information.

As a result, the type should look like:

charParser :: Char -> String -> Maybe (Char, Strring)
If the first argument is the first character of the second argument, the function returns Just(a, ss).
where a is the first argument and ss is the rest of the second argument.
If the first argument is not the first character of the second argument, the function returns Nothing.

If you want to parse next character you can use the rest of the string to the second argument.

Though it is possible to parse this way, it is not convenient to use this function because some mechnism
is required to process input string.

Monad is a one way doing this.


>
> data Parser a = Parser {parse :: String -> Maybe (a, String)}

                                     ^         ^    ^    ^
                                     |         |    |    |
                                     |         |    |    +-------- Next input
                                     |         |    +------------- Parsed result
                                     |         +------------------ You can return error by Nothing
                                     +---------------------------- Input

Please compare the types of parse and charParser.
Parser will be an instance of Functor, Applicative and Monad in this chapter.

> instance Functor Parser where
>   fmap f (Parser parse)  = Parser (\ss -> p f (parse ss))
>     where
>       p :: (a -> b) -> Maybe (a, String) -> Maybe (b, String)
>       p f Nothing = Nothing
>       p f (Just (a, ss)) = Just (f a, ss)
>
> instance Applicative Parser where
>   pure a = Parser (\ss -> Just (a, ss))
>   (Parser f) <*> (Parser v) = Parser (\ss1 -> let f' = f ss1 in
>                                                 case f' of
>                                                   Nothing -> Nothing
>                                                   Just (g, ss2) ->
>                                                      let v' = v ss2 in  -- forward ss2 to v
>                                                        case v' of
>                                                          Nothing -> Nothing
>                                                          Just (u, ss3) -> Just (g u, ss3)) -- return processed string
> instance Monad Parser where
>   return = pure
>   (Parser v) >>= f = Parser (\ss1 -> let v' = v ss1 in
>                                 case v' of
>                                   Nothing -> Nothing
>                                   Just (u, ss2) -> parse (f u) ss2)


> charP :: Char -> Parser Char
> charP ch = Parser (\ss -> f ss)
>   where
>     f []                  = Nothing
>     f (c :ss) | c == ch   = Just (c, ss)
>               | otherwise = Nothing
> charS :: Char -> Parser String
> charS ch = (:[]) <$> (charP ch)
> 
> runParser :: String -> Parser a -> Maybe (a, String)
> runParser ss (Parser parse) = parse ss

As the Parser is a function, we need to run the Parser by supplying input to parse.

>
> ab = runParser "abc" ((++) <$> charS 'a' <*> charS 'b')
> ab' = do
>     v1 <- charP 'a'
>     v2 <- charP 'b'
>     return [v1, v2]
>

> pairP :: Char -> Char -> Parser (Char, Char)
> pairP a b = do
>               l <- charP a
>               r <- charP b
>               return (l, r)
>
> pair  = runParser "abcdefg" $ pairP 'a' 'b'
> pair' = runParser "abcdefg" $ (,) <$> charP 'a' <*> charP 'b'
