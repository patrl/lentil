module Main where

import           Dhall
import           Lentil.Shake
import           Development.Shake.Forward
import           Development.Shake              ( liftIO
                                                , Action
                                                , putVerbose
                                                )
import           Development.Shake.FilePath     ( (</>) )
import           Data.Text                      ( pack
                                                , unpack
                                                )
import           Lentil.Types
import           Lentil.Serve

main :: IO ()
main = do

  config <- input auto configFile :: IO Config

  let d'                 = unpack $ siteDir config
  let d                  = unpack $ dataDir config
  let c                  = unpack $ cssDir config
  let cd                 = unpack $ contentDir config
  let t                  = unpack $ templateDir config
  let t'                 = unpack $ defaultLayout config

  let (tempFile :: Text) = pack $ "." </> d </> t </> t'

  print $ "building site in: " ++ d'

  -- This is an extremely simple shake build script which just copies the static css to the deploy folder.
  shakeArgsForward shOpts $ do

    copyStyleFiles (d </> c) (d' </> "css/")
    temp <- liftIO $ input auto $ tempFile :: Action (PageTemplate)
    urls <- buildPages (d </> cd) d' temp
    liftIO $ print urls

serve :: IO ()
serve = shakeArgsForward shOpts $ do
  config <- liftIO $ input auto "./data/config.dhall" :: Action Config
  putVerbose
    $  "Serving files in "
    ++ (unpack $ siteDir config)
    ++ "at http://localhost:8000"
  liftIO $ serveDir (unpack $ siteDir config) 8000

clean :: IO ()
clean = shakeArgsForward shOpts $ do
  config <- liftIO $ input auto "./data/config.dhall" :: Action Config
  putVerbose $ "Cleaning " ++ (unpack $ siteDir config)

configFile :: Text
configFile = "./data/config.dhall"
