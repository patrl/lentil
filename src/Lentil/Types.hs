-- |

module Lentil.Types where

import           Dhall

data Site = Site {
  siteTitle :: Text
  , sourceDir :: [FilePath]
  , dataDir :: [FilePath]
  , filesDir :: [FilePath]
  , deployDir :: FilePath
  , defaultLayout :: FilePath
  , indexFile :: FilePath
                 } deriving (Show, Read, Eq)
