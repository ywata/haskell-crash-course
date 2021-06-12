
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

putStr:: String -> IO ()
putStr = undefined
