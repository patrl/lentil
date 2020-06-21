let Content = < Markdown : Text | Org : Text | Plain : Text >

in    { metaTitle = "Home"
      , metaContent = Content.Markdown ./index.md as Text
      , metaStyle = "gruvbox.css"
      , metaDate = None Text
      }
    : ../types/Meta.dhall
