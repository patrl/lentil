{-# LANGUAGE OverloadedStrings #-}

module Lentil.Config where

import           System.FilePath()
import           Lentil.Types
import qualified Data.Text as T
import Dhall

parseSiteConfig :: T.Text -> IO (Site)
parseSiteConfig f = input auto f
