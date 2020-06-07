module Lentil.Shake where

import Development.Shake
import Development.Shake.FilePath
import Control.Monad
import Lentil.Types

copyStaticFiles :: FilePath -> FilePath -> Action ()
copyStaticFiles cssDir outputDir = do
  cssFiles <- getDirectoryFiles cssDir [ "//*.css" ]
  void $ forP cssFiles $ \filepath ->
    copyFileChanged (cssDir </> filepath) (outputDir </> filepath)

buildPage :: FilePath -> Action Page
buildPage = undefined
