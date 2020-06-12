{-# LANGUAGE OverloadedStrings #-}

module Lentil.Render where

import           Lentil.Types
import           Text.Pandoc             hiding ( Format )
import qualified Data.Text                     as T
import           Development.Shake.FilePath
import           Data.Char                      ( toLower )

convertMarkdownToHtmlString :: T.Text -> IO T.Text
convertMarkdownToHtmlString txt =
  runIOorExplode $ readMarkdown def txt >>= writeHtml5String def

formatFromExtension :: FilePath -> Format
formatFromExtension f = case (map toLower $ takeExtension f) of
  ".html"     -> HtmlFormat
  ".xhtml"    -> HtmlFormat
  ".markdown" -> MarkdownFormat
  ".md"       -> MarkdownFormat
  _           -> HtmlFormat
