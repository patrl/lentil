module Lentil.Shake where

import Development.Shake
import Development.Shake.FilePath
import Control.Monad

copyStaticFiles :: FilePath -> FilePath -> Action ()
copyStaticFiles cssDir outputDir = do
  cssFiles <- getDirectoryFiles cssDir [ "//*.css" ]
  void $ forP cssFiles $ \filepath ->
    copyFileChanged (cssDir </> filepath) (outputDir </> filepath)
