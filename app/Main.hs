{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Dhall

main :: IO ()
main = do
  (siteRaw :: Text) <- input auto "./data/site.dhall"
  print siteRaw
