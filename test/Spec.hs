-- {-# OPTIONAL_GHC -F -pgmF hspec-discover #-} is important.
-- If the line appears in Spec.hs specified in cabal file as main-is and
-- build-tool-depends: hspec-discover:hspec-discover
-- is also specified, then, Spec files are automatically searched.
{-# OPTIONS_GHC -F -pgmF hspec-discover #-}
