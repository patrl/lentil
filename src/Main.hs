{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import           Dhall
import           Lentil.Types
import           Lentil.Render
import           Lentil.Serve                   ( serveSite )
import           Lentil.Shake
import           Lentil.Pandoc
import qualified Data.Text.IO                  as T
import           Development.Shake
import           Development.Shake.Forward
import           Text.Pandoc
import GHC.IO.Encoding (getLocaleEncoding)

main :: IO ()
main = do

  getLocaleEncoding >>= print

  deployFolder <- input auto "(./data/config.dhall).outputFolder" :: IO FilePath -- read the output folder from the global dhall filepath
  print deployFolder
  staticFiles <- input auto "(./data/config.dhall).dataDir" :: IO FilePath

  -- Trying to retrieve and print the metadata from a file
  txt         <- T.readFile "./data/index.md"

    -- The following tests retrieving the title from pandoc metadata and printing it
  result1     <- runIO $ do
    (Pandoc meta _) <- readMarkdown defaultReaderOptions txt
    titleInlines    <- pure $ docTitle meta
    writeHtml5String defaultWriterOptions
      $ Pandoc mempty (pure $ Plain titleInlines)
  rst1 <- handleError result1
  print rst1

  -- -- This is an extremely simple shake build script which just copies the static css to the deploy folder.
  let shOpts = forwardOptions
        $ shakeOptions { shakeVerbosity = Chatty, shakeLintInside = ["\\"] }
  shakeArgsForward shOpts $ do
    generatedHtml <- renderMd txt
    f <- liftIO $ input auto "(./data/layout.dhall)" :: Action (Page -> Text)
    copyStaticFiles (staticFiles <> "css") deployFolder
    liftIO $ T.writeFile
      (deployFolder <> "index.html")
      (f $ Page { pageTitle = rst1
                , contents  = generatedHtml
                , style     = "gruvbox.css"
                }
      )
    liftIO serve


serve :: IO ()
serve = do
  deployFolder <- input auto "(./data/config.dhall).outputFolder" :: IO FilePath
  serveSite deployFolder
