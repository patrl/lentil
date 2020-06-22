let Content = < Markdown : Text | Org : Text | Plain : Text >

in    { metaTitle = Content.Markdown "post 1"
      , metaContent = Content.Markdown ./post1.md as Text
      , metaStyle = "gruvbox.css"
      , metaDate = Some "2020-07-16"
      }
    : ../../types/Meta.dhall
