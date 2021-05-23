module IO where

{-                                              External world                                   
+-------------------------------------------+       +---------+
| IO a                                      | print |         |
|             +------------------------+    | ====> | monitor |
|             | Function               |    |       +---------+
|             |                        |    |                      
|             |                        |    |       +---------+
|             |                        |    |       |         |
|             +------------------------+    | <==== |Keyboard |
|                                           | input +---------+
+-------------------------------------------+       
If you only use feature of Haskelled mentioned in
BasicTypes, BasicFunctions and AbstracTypes, you cannot interact with outside world.
You cannot get information from keyboard nor you cannot print information on monitor.

If this is the case, you cannot do anything important with Haskell.
IO is provided for such purposes.
-}



