{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Dhall
import Lentil.Types
import Lentil.Render
import Lentil.Shake
import Lentil.Pandoc
import qualified Data.Text.IO as T
import Development.Shake
import Development.Shake.Forward
import Text.Pandoc

main :: IO ()
main = do


  -- deployFolder <- input auto "(./data/config.dhall).outputFolder" :: IO FilePath -- read the output folder from the global dhall filepath
  -- print deployFolder
  -- staticFiles <- input auto "(./data/config.dhall).dataDir" :: IO FilePath
 
  -- fileContents <- T.readFile "./data/index.md"
  -- (Pandoc meta _) <-  runIO $ readMarkdown def fileContents
  -- doctitle <- titleToHtml5 meta
  -- print doctitle

  -- Trying to retrieve and print the metadata from a file
  txt <- T.readFile "./data/index.md"
  result1 <- runIO $ do
    (Pandoc meta _) <- readMarkdown def txt
    titleInlines <- pure $ docTitle meta
    writeHtml5String def $ Pandoc mempty (pure $ Plain titleInlines)
  rst1 <- handleError result1
  print rst1



  -- excontents <- convertMarkdownToHtmlString readExample
  -- -- siteConfig <- input auto "./data/config.dhall" :: IO Site -- Read in the global site configuration from config.dhall
  -- pagetitle <- input auto "(./data/config.dhall).siteTitle"
  -- pageInfo <- return $ Page { pageTitle = pagetitle, contents = excontents, style = "css/gruvbox.css" }
  -- pageTemplate <- input auto "./data/layout.dhall" :: IO (Page -> Text)
  -- templated <- return $ pageTemplate pageInfo

  -- print (siteConfig :: Site)
  -- print (title :: Text)
  -- print pageInfo
  -- print templated

  -- -- This is an extremely simple shake build script which just copies the static css to the deploy folder.
  -- let shOpts = forwardOptions $ shakeOptions { shakeVerbosity = Chatty, shakeLintInside = ["\\"]}
  -- shakeArgsForward shOpts $ copyStaticFiles (staticFiles <> "css") deployFolder
