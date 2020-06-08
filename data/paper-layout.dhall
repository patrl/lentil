let concatSep = https://prelude.dhall-lang.org/v9.0.0/Text/concatSep

in    λ(paper : { date : Text, title : Text, url : Text, authors : List Text })
    → concatSep
      ". "
      [ concatSep ", " paper.authors
      , "${paper.date}"
      , "${paper.title}"
      , ''
        <a href="${paper.url}">Read.</a>
        ''
      ]
