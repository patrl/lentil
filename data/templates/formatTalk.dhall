let concatSep = https://prelude.dhall-lang.org/Text/concatSep

let concat = https://prelude.dhall-lang.org/Text/concat

let defaultMap = https://prelude.dhall-lang.org/Text/defaultMap

let ResourceUrl = < Slides : Text | Handout : Text | NoUrl >

let printUrl =
      λ(url : ResourceUrl) →
        merge
          { Slides = λ(t : Text) → ". [Slides](${t})."
          , Handout = λ(t : Text) → ". [Handout](${t})."
          , NoUrl = ""
          }
          url

in  λ(talk : ../types/Talk.dhall) →
          "- "
      ++  concatSep
            ". "
            [ concatSep ", " ([ "Patrick D. Elliott" ] # talk.coauthors)
            , talk.date
            , talk.title
            ]
      ++  printUrl talk.url
