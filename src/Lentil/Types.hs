{-# LANGUAGE DeriveGeneric #-}

module Lentil.Types where

import           Dhall

data Site = Site { siteTitle :: Text
                 , outputFolder :: Text
                 , dataDir :: Text
                 , defaultLayout :: Text
                 } deriving (Show, Read, Eq, Generic)

data Page = Page { pageTitle :: Text,
                   contents :: Text,
                   style :: Text } deriving (Show, Read, Eq, Generic)

instance FromDhall Site
instance FromDhall Page
instance ToDhall Page

data Format = HtmlFormat | MarkdownFormat deriving (Eq,Show,Read)
