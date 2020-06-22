let Content = < Markdown : Text | Org : Text | Plain : Text >

in    { metaTitle = Content.Org "post 2"
      , metaContent = Content.Org ./post2.org as Text
      , metaStyle = "gruvbox.css"
      , metaDate = None Text
      }
    : ../../types/Meta.dhall
