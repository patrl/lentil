{-# LANGUAGE DeriveGeneric,DeriveAnyClass #-}

module Lentil.Types where

import           Dhall

-- This should correspond to the dhall datatype in config.dhall
data Site = Site { siteTitle :: Text
                 , outputFolder :: Text
                 , dataDir :: Text
                 , defaultLayout :: Text
                 } deriving (Show, Read, Eq, Generic, FromDhall)

data Page = Page { pageTitle :: Text,
                   contents :: Text,
                   style :: Text,
                   date :: Text } deriving (Show, Read, Eq, Generic, FromDhall, ToDhall)

data PageMeta = PageMeta { metaTitle :: Text, metaStyle :: Text } deriving  (Show,Read,Eq,Generic,FromDhall)

data SitePage = SitePage {
  title :: Text
  , pageContents :: Text
  }

data Format = HtmlFormat | MarkdownFormat | OrgFormat deriving (Eq,Show,Read)
