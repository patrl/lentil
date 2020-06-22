{-|
Module      : Lentil.Types
-}

{-# LANGUAGE DeriveAnyClass,DerivingStrategies,DeriveGeneric,StandaloneDeriving,TemplateHaskell,OverloadedStrings #-}

module Lentil.Types where

import           Dhall
import           Dhall.TH

makeHaskellTypes [ MultipleConstructors "Content" "./data/types/Content.dhall"
                 , SingleConstructor "Meta" "Meta" "./data/types/Meta.dhall"
                 , SingleConstructor "Config" "Config" "./data/types/Config.dhall"
                 , SingleConstructor "Page" "Page" "./data/types/Page.dhall"]

-- | A type synonym for page templates.
type PageTemplate = Page -> Text

-- | Formats supported by lentil.
data Format = HtmlFormat | MarkdownFormat | OrgFormat deriving (Eq,Show,Read)
