-- | 

module Lentil.Serve (serveDir) where

import           Network.Wai.Handler.Warp       ( run )
import           Network.Wai.Application.Static

serveDir :: FilePath -> Int -> IO ()
serveDir dir port = run port (staticApp (defaultFileServerSettings dir))
