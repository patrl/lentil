{-# LANGUAGE OverloadedStrings, DuplicateRecordFields, LambdaCase #-}

module Lentil.Shake
  ( shOpts
  , copyStyleFiles
 , buildPages
  , cleanDir
  )
where

import           Lentil.Pandoc
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

shOpts :: ShakeOptions
shOpts = forwardOptions $ shakeOptions { shakeVerbosity  = Verbose
                                       , shakeLintInside = ["\\"]
                                       , shakeProgress   = progressSimple
                                       }


copyStyleFiles :: FilePath -> FilePath -> Action ()
copyStyleFiles d d' = do
  fs <- getDirectoryFiles d ["//*.css"]
  void $ forP fs $ \f -> copyFileChanged (d </> f) (d' </> f) -- when shake options are "verbose", this implicity sends out a message about copying the files.

buildPages :: FilePath -> FilePath -> PageTemplate -> Action ()
buildPages contDir outputDir t = do
  putVerbose $ "Loading files in " ++ contDir
  pageFiles <- getDirectoryFiles contDir ["//*.dhall"]

  void $ forP pageFiles $ \f ->
    do
      meta <- liftIO $ D.input D.auto $ pack $ "." </> contDir </> f :: Action PageMeta
      tit <- liftPandoc $ myMdToHtml $ (title :: PageMeta -> D.Text) meta
      let css = pack $ "./css/" ++ (styleFile :: PageMeta -> FilePath) meta
      let fcont = contentFile meta
      now <- liftPandoc $ liftM (pack . show) P.getCurrentTime
      cont <- case fileToFormat fcont of
          Just HtmlFormat -> liftIO $ T.readFile (contDir </> (takeDirectory f) </> fcont)
          Just MarkdownFormat -> do
            md <- liftIO $ T.readFile (contDir </> (takeDirectory f) </> fcont)
            liftPandoc $ myMdToHtml md
          Just OrgFormat -> do
            org <- liftIO $ T.readFile (contDir </> (takeDirectory f) </> fcont)
            liftPandoc $ myOrgToHtml org
          Nothing -> do
            putVerbose $ "The format " ++ takeExtension fcont ++ "is unsupported."
            return ""

      let processed = Page tit cont css now

     
      putVerbose $ "writing to " ++ (outputDir </> (f -<.> "html"))
      writeFileChanged (outputDir </> (f -<.> "html")) (unpack $ t processed)

fileToFormat :: FilePath -> Maybe Format
fileToFormat f = case takeExtension f of
  ".md"       -> Just MarkdownFormat
  ".markdown" -> Just MarkdownFormat
  ".org"      -> Just OrgFormat
  ".html"     -> Just HtmlFormat
  _           -> Nothing

cleanDir :: FilePath -> Action ()
cleanDir f = do
  putInfo $ "Cleaning files in " ++ show f
  removeFilesAfter f ["//*"]
