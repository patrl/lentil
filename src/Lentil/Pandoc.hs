-- | 

module Lentil.Pandoc where

import           Text.Pandoc
import           Development.Shake (liftIO,Action)
import qualified Data.Text                     as T

defaultReaderOptions :: ReaderOptions
defaultReaderOptions = def { readerExtensions = mconcat [pandocExtensions] }

defaultWriterOptions :: WriterOptions
defaultWriterOptions = def { writerExtensions = exts, writerHTMLMathMethod = MathML }
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
-- We want to handle errors within the IO monad.
liftPandoc :: PandocIO a -> Action a
liftPandoc = liftIO . runIOorExplode

-- Note that this drops any associated metadata
renderMd :: T.Text -> Action (T.Text)
renderMd txt =  liftPandoc $ do
  (Pandoc _ body) <- myReadMarkdown txt
  myWriteHtml5String (Pandoc mempty body)

myReadOrg :: T.Text -> PandocIO Pandoc
myReadOrg = readOrg defaultReaderOptions

myReadMarkdown :: T.Text -> PandocIO Pandoc
myReadMarkdown = readMarkdown defaultReaderOptions

myWriteHtml5String :: Pandoc-> PandocIO T.Text
myWriteHtml5String = writeHtml5String defaultWriterOptions

getMeta :: Pandoc -> Meta
getMeta (Pandoc meta _) = meta

metaToHtmlTitle :: Meta -> Action (T.Text)
metaToHtmlTitle =
  liftPandoc
    . myWriteHtml5String
    . Pandoc mempty
    . pure
    . Plain
    . docTitle
