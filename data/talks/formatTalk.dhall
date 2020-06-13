let concatSep = https://prelude.dhall-lang.org/Text/concatSep

let concat = https://prelude.dhall-lang.org/Text/concat

let defaultMap = https://prelude.dhall-lang.org/Text/defaultMap

in  λ(talk : ./Talk.dhall) →
          "<li><span>"
      ++  concatSep
            ". "
            [ concatSep ", " ([ "Patrick D. Elliott" ] # talk.coauthors)
            , talk.date
            , talk.title
            , concat
                [ defaultMap Text ./handoutToLink.dhall talk.handoutUrl
                , defaultMap Text ./slideToLink.dhall talk.slideUrl
                ]
            ]
      ++  "</span></li>"
