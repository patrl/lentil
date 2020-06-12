let SiteConfig
    : Type
    = { siteTitle : Text
      , outputFolder : Text
      , dataDir : Text
      , defaultLayout : Text
      , siteAuthor : Text
      }

in    { siteTitle = "Patrick D. Elliott"
      , outputFolder = "site"
      , dataDir = "data/"
      , defaultLayout = "data/templates/default.dhall"
      , siteAuthor = "Patrick D. Elliott"
      }
    : SiteConfig
