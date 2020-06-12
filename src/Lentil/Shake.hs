{-# LANGUAGE OverloadedStrings #-}

module Lentil.Shake
  ( shOpts
  , copyStyleFiles
  , buildPages
  , serve
  , clean
  )
where

import           Lentil.Pandoc                  ( pandocIOToAction
                                                , myReadMarkdown
                                                , myWriteHtml5String
                                                )
import           Development.Shake
import           Development.Shake.Forward
import           Development.Shake.FilePath
import           Control.Monad
import qualified Text.Pandoc                   as P
import qualified Dhall                         as D -- we only want the Text datatype
import qualified Data.Text.IO                  as T
import           Data.Text                      ( unpack
                                                , pack
                                                )
import           Lentil.Types
import           Lentil.Serve

shOpts :: ShakeOptions
shOpts = forwardOptions $ shakeOptions { shakeVerbosity  = Verbose
                                       , shakeLintInside = ["\\"]
                                       , shakeProgress   = progressSimple
                                       }

copyStyleFiles :: FilePath -> FilePath -> Action ()
copyStyleFiles cssDir outputDir = do
  cssFiles <- getDirectoryFiles cssDir ["//*.css"]
  void $ forP cssFiles $ \filepath ->
    copyFileChanged (cssDir </> filepath) (outputDir </> filepath) -- when shake options are "verbose", this implicity sends out a message about copying the files.

buildPages :: FilePath -> FilePath -> (Page -> D.Text) -> Action ()
buildPages contentDir outputDir t = do
  putVerbose $ "Parsing markdown files in " ++ contentDir
  mdFiles <- getDirectoryFiles contentDir ["//*.md"]
  putVerbose "Getting current time"
  now <- pandocIOToAction P.getCurrentTime
  putVerbose $ "The current time is: " ++ show now
  void $ forP mdFiles $ \filepath -> do
    md           <- liftIO $ T.readFile $ contentDir </> filepath
    doc          <- pandocIOToAction $ myReadMarkdown md
    htmlTitle    <- metaToHtmlTitle $ getMeta doc
    htmlContents <- pandocIOToAction $ myWriteHtml5String doc
    let page = t $ Page { pageTitle = htmlTitle
                        , contents  = htmlContents
                        , style     = "/css/gruvbox.css"
                        , date      = pack $ show now
                        } -- it's important that the link to the style file should be absolute relative to the site root
    putVerbose $ "writing html files to " ++ outputDir
    writeFileChanged (outputDir <//> (filepath -<.> "html")) (unpack page)

getMeta :: P.Pandoc -> P.Meta
getMeta (P.Pandoc meta _) = meta

metaToHtmlTitle :: P.Meta -> Action (D.Text)
metaToHtmlTitle =
  pandocIOToAction
    . myWriteHtml5String
    . P.Pandoc mempty
    . pure
    . P.Plain
    . P.docTitle

serve :: FilePath -> Action ()
serve dir = do
  putVerbose $ "Serving files in " ++ dir ++ "at http://localhost:8000"
  liftIO $ serveSite dir

clean :: FilePath -> Action ()
clean f = do
  putInfo $ "Cleaning files in " ++ show f
  removeFilesAfter f ["//*"]
