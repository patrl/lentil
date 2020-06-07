-- | 

module Lentil.Pandoc where

import           Text.Pandoc
-- import           Development.Shake
-- import qualified Data.Map as M
import qualified Data.Text as T

defaultMarkdownOptions :: ReaderOptions
defaultMarkdownOptions = def { readerExtensions = exts }
 where
  exts = mconcat
    [ extensionsFromList
      [ Ext_yaml_metadata_block
      , Ext_fenced_code_attributes
      , Ext_auto_identifiers
      ]
    , githubMarkdownExtensions
    ]

titleToHtml5 :: PandocMonad m => Meta -> m T.Text
titleToHtml5 = writeHtml5String def . Pandoc mempty . mempty . docTitle
