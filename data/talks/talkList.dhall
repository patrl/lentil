let concatMapSep = https://prelude.dhall-lang.org/Text/concatMapSep

in  concatMapSep "\n" ./Talk.dhall ./formatTalk.dhall ./talks.dhall
