{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import           Dhall
import           Lentil.Shake
-- import           Lentil.Pandoc
import           Development.Shake.Forward
import Development.Shake (liftIO,Action)
import Lentil.Types
-- import           Text.Pandoc

main :: IO ()
main = do

  deployFolder <- input auto "(./data/config.dhall).outputFolder" :: IO FilePath -- read the output folder from the global dhall filepath
  print deployFolder
  staticFiles <- input auto "(./data/config.dhall).dataDir" :: IO FilePath

  -- Trying to retrieve and print the metadata from a file

  let cssDir = staticFiles <> "css/"
 
  let contentDir = staticFiles <> "content/"

  print contentDir

  -- -- This is an extremely simple shake build script which just copies the static css to the deploy folder.
  shakeArgsForward shOpts $ do
    template <- liftIO $ input auto "./data/layout.dhall" :: Action (Page -> Text)
    copyStyleFiles cssDir (deployFolder <> "css/")
    buildPages contentDir deployFolder template
    serve deployFolder
