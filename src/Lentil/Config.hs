{-# LANGUAGE OverloadedStrings #-}

module Lentil.Config where

import           Lentil.Types
import qualified Data.Text as T
import Dhall

parseSiteConfig :: T.Text -> IO (Site)
parseSiteConfig f = input auto f
