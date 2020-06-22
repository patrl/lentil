{-# LANGUAGE OverloadedStrings,LambdaCase #-}

module Lentil.Shake
  ( shOpts
  , copyStyleFiles
  , buildPages
  , cleanDir
  , parseMeta
  -- , copyStaticFiles
  )
where

import           Lentil.Pandoc
import           Development.Shake
import           Development.Shake.Forward
import           Development.Shake.FilePath
import           Control.Monad
import qualified Text.Pandoc                   as P
import qualified Dhall                         as D -- we only want the Text datatype
import           Data.Text                      ( unpack
                                                , pack
                                                , Text
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

-- -- | copies all files from static directories to an output directory, matching the directory structure
-- copyStaticFiles :: [FilePath] -> FilePath -> Action ()
-- copyStaticFiles ds d = do
--   void $ forP ds $ \d' ->
--     do
--       fs <- getDirectoryFiles d' ["//*"]
--       void $ forP fs $ \f -> copyFileChanged (d' </> f) (d </> f)

parseMetaContent :: Content -> Action (Text)
parseMetaContent = \case
  (Markdown t) -> liftPandoc $ myMdToHtml t
  (Org t) -> liftPandoc $ myOrgToHtml t
  (Plain t) -> return t

parseMetaDate :: Maybe Text -> Action (Text)
parseMetaDate = \case
  (Just d) -> return d
  _ -> liftPandoc $ liftM (pack . show) P.getCurrentTime

parseMeta :: Meta -> Action (Page)
parseMeta m = do
  let [c,tit] = [metaContent,metaTitle] <*> pure m
  let dat = metaDate m
  let css = pack $ "." </> "css" </> (unpack $ metaStyle m)
  c' <- parseMetaContent c
  t' <- parseMetaContent tit
  d' <- parseMetaDate dat
  return $ Page t' c' css d'

buildPages :: FilePath -> FilePath -> PageTemplate -> Action ()
buildPages d d' t = do
  putVerbose $ "loading files in " ++ d
  pageFiles <- getDirectoryFiles d ["//*.dhall"]

  void $ forP pageFiles $ \f ->
    do
      m <- liftIO $ D.input D.auto $ pack $ "." </> d </> f :: Action Meta
      p <- parseMeta m
      putVerbose $ "writing to " ++ (d' </> (f -<.> "html"))
      writeFileChanged (d' </> (f -<.> "html")) (unpack $ t p)

cleanDir :: FilePath -> Action ()
cleanDir f = do
  putInfo $ "Cleaning files in " ++ show f
  removeFilesAfter f ["//*"]
