
> module Main where

The aim of this crash course is to cover important concepts of Haskell very quickly.
Self-studying Haskell is somewhat hard in the beginning,
and this material is intended to resolve this difficulty by solving some excercises with an intermediate Haskeller.
After you finish this material with your tutor, you can experience the productivity and fun of Haskell on your own.

In this material, the author plans to cover basic functionality of Haskell.
That should cover:

Tools
* REPL
* Literate programming

Language
* Types
    * ADT(Abstract Data Types)
    * Pattern matching
    * Compile errors(~= type error)
* Functions
    * Recursive functions
    * Composition of functions and higher order functions
* Unit Tests
* IO

As types and functions are interrelated, the order of the subjects presented is different from the above.


> import BasicType
> import BasicFunction
> import AbstractDataType
> import Recursive

After discussing the Recursive module, take a look at test/RecursiveSpec.hs

> import TypeClass hiding (return)

In test/RecursiveSpec.hs, there is some test code commented out to avoid test errors.
The author suggests you look at the "property test" code.

> import IO
> import HigherOrderFunction
>
> main :: IO()
> main = return ()

Some part of the difficulity in learning Haskell is because of the many variations of
compilation errors. There are examples of error messages in error/ directory.
