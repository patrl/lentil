-- | 

module Lentil.Serve (serveSite) where

import           Network.Wai.Handler.Warp       ( run )
import           Network.Wai.Application.Static

serveSite :: FilePath -> Int -> IO ()
serveSite dir port = run port (staticApp (defaultFileServerSettings dir))
