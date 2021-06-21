
> module Main where

The aim of this crash course is to cover important concepts of Haskell very quickly.
Because self studying Haskell is somewhat hard in the begging,
this material is intended to resolve the issue solving some excercises with a intermediate Haskeller .
After you finish this material with your tutor, you'll experience productivity of Haskell and fun.

In this material, the author plants to cover basic functionality of Haskell.
That should cover:
* Tool
- REPL
- Literate programming

* Language
- Type
 - ADT(Abstract Data Type)
 - Pattern match
 - Compile error(~= type error)
- Function
 - Recursive function
 - Composition of functions and higher order functions
- Unit Test
- IO

As type and functions are interrelated, the order of the subjects presented is different from
the above. 


> import BasicType
> import BasicFunction
> import AbstractDataType
> import Recursive

After discussing Recursive module, try to look at test/RecursiveSpec.hs

> import TypeClass hiding (return)

In test/RecursiveSpec.hs, there are some test code commenting out to avoid
test error, suggest to look at the property test code.

> import IO
> import HigherOrderFunction
>
> main :: IO()
> main = return ()

Some part of the difficulity of learning Haskell is because of many variation of
compilation error, error messages are collected in error/ directory.







