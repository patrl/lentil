-- | 

module Lentil.Serve (serveSite) where

import           Network.Wai.Handler.Warp       ( run )
import           Network.Wai.Application.Static

serveSite :: FilePath -> IO ()
serveSite dir = run 8000 (staticApp (defaultFileServerSettings dir))
