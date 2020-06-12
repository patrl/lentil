{-# LANGUAGE OverloadedStrings #-}

module Lentil.Shake
  ( shOpts
  , copyStyleFiles
  , buildPages
  , serve
  , clean
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

  -- The following retrives the filepaths of the markdown files in contentDir; filepaths returned are relative to the contentDir root.
  -- This will mean that we retain the directory structure of the contentDir; this will provide the site structure too.
  putVerbose $ "Loading files in " ++ contentDir
  mdFiles <- getDirectoryFiles contentDir ["//*.md", "//*.html", "//*.org"]

  -- The following loads the current time.
  putVerbose "Getting current time"
  now <- liftPandoc P.getCurrentTime
  putVerbose $ "The current time is: " ++ show now

  let loadFile f = T.readFile $ contentDir </> f
      loadMeta f = T.readFile $ contentDir </> (f -<.> "dhall")
      parseMeta d = D.input D.auto d
      mkPage tit cont sty dat = t $ Page { pageTitle = tit, contents = cont, style = sty, date = dat }

  void $ forP mdFiles $ \filepath -> case fileToFormat filepath of
    Just HtmlFormat -> do
      copyFileChanged (contentDir </> filepath) (outputDir </> filepath)
    Just _ -> do
      f     <- liftIO $ loadFile filepath
      meta <- liftIO $ loadMeta filepath
      metaParsed <- liftIO $ parseMeta meta :: Action (PageMeta)
      doc <- liftPandoc $ (if (fileToFormat filepath == Just OrgFormat) then myReadOrg else myReadMarkdown) f
      htmlContents <- liftPandoc $ myWriteHtml5String doc
      let page = mkPage (metaTitle metaParsed) htmlContents (metaStyle metaParsed) (pack $ show now)
      putVerbose $ "writing to " ++ (outputDir </> (filepath -<.> "html"))
      writeFileChanged (outputDir </> (filepath -<.> "html")) (unpack page)
    _ -> do
      putVerbose "Unsupported fileformat"


fileToFormat :: FilePath -> Maybe Format
fileToFormat f = case takeExtension f of
  ".md"       -> Just MarkdownFormat
  ".markdown" -> Just MarkdownFormat
  ".org"      -> Just OrgFormat
  ".html"     -> Just HtmlFormat
  _           -> Nothing

serve :: FilePath -> Int -> Action ()
serve dir port = do
  putVerbose $ "Serving files in " ++ dir ++ "at http://localhost:8000"
  liftIO $ serveSite dir port

clean :: FilePath -> Action ()
clean f = do
  putInfo $ "Cleaning files in " ++ show f
  removeFilesAfter f ["//*"]
