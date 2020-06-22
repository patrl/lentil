let Content = < Markdown : Text | Org : Text | Plain : Text >

in    { metaTitle = Content.Markdown "Drafts"
      , metaContent =
          Content.Markdown
            ''
            # Drafts

            - [post 1](/drafts/post1.html)
            - [post 2](/drafts/post2.html)
            ''
      , metaStyle = "gruvbox.css"
      , metaDate = None Text
      }
    : ../../types/Meta.dhall
