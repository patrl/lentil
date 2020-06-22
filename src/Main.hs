{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Dhall
import           Lentil.Shake
import           Development.Shake.Forward
import Development.Shake (liftIO,Action,putVerbose)
import Development.Shake.FilePath ((</>))
import Data.Text (pack,unpack)
import Lentil.Types
import Lentil.Serve
-- import           Text.Pandoc

main :: IO ()
main = do

  config <- input auto "./data/config.dhall" :: IO Config

  let (deployPath :: FilePath) = unpack $ siteDir config

  print $ "building site in: " ++ deployPath

  -- -- This is an extremely simple shake build script which just copies the static css to the deploy folder.
  -- shakeArgsForward shOpts $ do
  --   copyStyleFiles (dataDir config </> cssDir config) (siteDir config </> "css/")
  --   t <- liftIO $ input auto $ pack $ "." </> dataDir config </> templateDir config </> defaultLayout config :: Action (Page -> Text)
  --   liftIO $ print ("placeholder" :: String)
  --   buildPages (dataDir config </> contentDir config) (siteDir config) t

serve :: IO ()
serve = shakeArgsForward shOpts $ do
  config <- liftIO $ input auto "./data/config.dhall" :: Action Config
  putVerbose $ "Serving files in " ++ (unpack $ siteDir config) ++ "at http://localhost:8000"
  liftIO $ serveDir (unpack $ siteDir config) 8000

clean :: IO ()
clean = shakeArgsForward shOpts $ do
  config <- liftIO $ input auto "./data/config.dhall" :: Action Config
  putVerbose $ "Cleaning " ++ (unpack $ siteDir config)


configFile :: FilePath
configFile = "./data/config.dhall"
