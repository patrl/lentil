let Content = < Markdown : Text | Org : Text | Plain : Text >

in    { metaTitle = "post 1"
      , metaContent = Content.Markdown ./post1.md as Text
      , metaStyle = "gruvbox.css"
      , metaDate = None Text
      }
    : ../../types/Meta.dhall
