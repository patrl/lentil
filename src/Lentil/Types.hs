{-|
Module      : Lentil.Types
Description : This module establishes the source of truth for the .dhall files used to configure the site.
-}

{-# LANGUAGE DeriveGeneric #-}

module Lentil.Types where

import           Dhall

-- | The source of truth for config.dhall.
data Config = Config {
  title :: Text -- ^ The title of the website.
  , siteDir :: FilePath -- ^ The directory the site is deployed to.
  , dataDir :: FilePath -- ^ The directory containing the everything necessary to build the site.
  , contentDir :: FilePath -- ^ The directory containing the page configuration (relative to dataDir).
  , cssDir :: FilePath -- ^ The directory containing the static css files (relative to dataDir).
  , staticDirs :: [FilePath]
  , templateDir :: FilePath -- ^ The directory containing the template files (relative to dataDir).
  , defaultLayout :: FilePath -- ^ The location of the default template used for pages (relative to templateDir).
  , author :: Text -- ^ The author of the site.
}
  deriving (Show, Read, Eq, Generic)

instance FromDhall Config

-- | The source of truth for the dhall files used to configure pages.
data Meta = Meta { metaTitle :: Text, -- ^ The page title (as markup)
                   metaContent :: FilePath, -- ^ The location of the contents of the page.
                   metaStyle :: FilePath, -- ^ The location of the css file used for the page.
                   metaDate :: Maybe Text -- ^ Optionally, the date of publication.
                         }
              deriving (Show, Read, Eq, Generic)

instance FromDhall Meta
instance ToDhall Meta

-- | The type of something that can be transformed by a PageTemplate into a page (text).
data Page = Page { pageTitle :: Text -- ^ The page title (as html)
                 , pageContents :: Text -- ^ The contents of the page (as html)
                 , pageStyle :: Text -- ^ The style of the page (as an url)
                 , pageDate :: Text -- ^ The date of modification
                 }
          deriving (Show, Read, Eq, Generic)

instance FromDhall Page
instance ToDhall Page

-- | A type synonym for page templates.
type PageTemplate = Page -> Text

-- | Formats supported by lentil.
data Format = HtmlFormat | MarkdownFormat | OrgFormat deriving (Eq,Show,Read)
