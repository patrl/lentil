let concatMapSep = https://prelude.dhall-lang.org/Text/concatMapSep

let concat = https://prelude.dhall-lang.org/Text/concat

let talkList =
      concatMapSep "\n" ../types/Talk.dhall ./formatTalk.dhall ./talks.dhall

in      ''
        # Talks

        ''
    ++  talkList
