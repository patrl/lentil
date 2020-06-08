-- | 

module Lentil.Pandoc where

import           Text.Pandoc
import           Development.Shake
import qualified Data.Text                     as T

defaultReaderOptions :: ReaderOptions
defaultReaderOptions = def { readerExtensions = mconcat [pandocExtensions] }

defaultWriterOptions :: WriterOptions
defaultWriterOptions = def { writerExtensions = exts }
 where
  exts = mconcat
    [ extensionsFromList
        [ Ext_auto_identifiers
        , Ext_native_divs
        , Ext_line_blocks
        , Ext_native_spans
        ]
    ]

-- Handle possible pandoc failure within IO and lift the result into the Action monad.
pandocIOToAction :: PandocIO a -> Action a
pandocIOToAction = liftIO . runIOorExplode

renderMd :: T.Text -> Action (T.Text)
renderMd txt =  pandocIOToAction $ (readMarkdown defaultReaderOptions txt) >>= writeHtml5String defaultWriterOptions
