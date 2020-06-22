let Content = < Markdown : Text | Org : Text | Plain : Text >

in    { metaTitle = Content.Markdown "Home"
      , metaContent = Content.Markdown ./index.md as Text
      , metaStyle = "gruvbox.css"
      , metaDate = None Text
      }
    : ../types/Meta.dhall
