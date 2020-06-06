{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Dhall
import Lentil.Types
import Lentil.Render
import Lentil.Shake
import qualified Data.Text.IO as T
import Development.Shake
import Development.Shake.Forward

main :: IO ()
main = do
 
  let shOpts = forwardOptions $ shakeOptions { shakeVerbosity = Chatty, shakeLintInside = ["\\"]}
 
  deployFolder <- input auto "(./data/config.dhall).outputFolder" :: IO FilePath -- read the output folder from the global dhall filepath
  staticFiles <- input auto "(./data/config.dhall).dataDir" :: IO FilePath
 
  print deployFolder
  readExample <- T.readFile "./data/index.md"
  excontents <- convertMarkdownToHtmlString readExample
  -- siteConfig <- input auto "./data/config.dhall" :: IO Site -- Read in the global site configuration from config.dhall
  pagetitle <- input auto "(./data/config.dhall).siteTitle"
  pageInfo <- return $ Page { pageTitle = pagetitle, contents = excontents, style = "css/gruvbox.css" }
  pageTemplate <- input auto "./data/layout.dhall" :: IO (Page -> Text)
  templated <- return $ pageTemplate pageInfo

  -- print (siteConfig :: Site)
  -- print (title :: Text)
  -- print pageInfo
  -- print templated
  print templated

  shakeArgsForward shOpts $ copyStaticFiles (staticFiles <> "css") deployFolder
