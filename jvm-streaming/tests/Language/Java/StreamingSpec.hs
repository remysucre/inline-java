{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}

module Language.Java.StreamingSpec where

import Data.Int
import Language.Java
import Language.Java.Inline
import Language.Java.Streaming ()
import Test.Hspec
import Streaming (Stream, Of)
import qualified Streaming.Prelude as Streaming

spec :: Spec
spec = do
    describe "iteration" $ do
      it "succeeds on empty lists" $ do
        vals <- reflect [1..0 :: Int32]
        iterator <- [java| java.util.Arrays.asList($vals).iterator() |]
        stream <- reify iterator
        Streaming.toList_ stream `shouldReturn` [1..0 :: Int32]
      it "succeeds on singleton lists" $ do
        vals <- reflect [1 :: Int32]
        iterator <- [java| java.util.Arrays.asList($vals).iterator() |]
        stream <- reify iterator
        Streaming.toList_ stream `shouldReturn` [1 :: Int32]
      it "succeeds on non-trivial lists" $ do
        vals <- reflect [1..10000 :: Int32]
        iterator <- [java| java.util.Arrays.asList($vals).iterator() |]
        stream <- reify iterator
        Streaming.toList_ stream `shouldReturn` [1..10000 :: Int32]
    describe "streams" $ do
      it "have the property that reify . reflect == id" $ do
        iterator <- reflect (Streaming.each [1..10000] :: Stream (Of Int32) IO ())
        stream <- reify iterator
        Streaming.toList_ stream `shouldReturn` [1..10000 :: Int32]
