let Content = < Markdown : Text | Org : Text | Plain : Text >

in    { metaTitle = Content.Markdown "Talks"
      , metaContent = Content.Markdown ../../templates/talkList.dhall
      , metaStyle = "gruvbox.css"
      , metaDate = None Text
      }
    : ../../types/Meta.dhall
