module Main where

import Language.Java (withJVM)
import qualified Spec
import Test.Hspec

main :: IO ()
main = withJVM [] $ hspec Spec.spec

-- {-# LANGUAGE DataKinds #-}
-- {-# LANGUAGE QuasiQuotes #-}
-- {-# LANGUAGE OverloadedStrings #-}
-- {-# OPTIONS_GHC -fplugin=Language.Java.Inline.Plugin #-}
-- module Main where
-- 
-- import Data.Text (Text)
-- import Language.Java
-- import Language.Java.Inline
-- 
-- main :: IO ()
-- main = withJVM [] $ do
--     message <- reflect ("Hello World!" :: Text)
--     [java| { } |]
