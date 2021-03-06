let ResourceUrl = < Slides : Text | Handout : Text | NoUrl >

in    [ { title = "Nesting habits of flightless <i>wh-</i>expressions"
        , date = "2019"
        , coauthors = [] : List Text
        , url = ResourceUrl.Slides "https://patrl.keybase.pub/slides/nantes.pdf"
        , event = "Talk given at the workshop <i>Complex wh-expressions</i>"
        , location = "Nantes"
        }
      , { title = "Two souls of disjunction"
        , date = "2019"
        , coauthors = [] : List Text
        , url =
            ResourceUrl.Slides
              "https://patrl.keybase.pub/slides/berlin-disj.pdf"
        , event =
            "Talk given at the workshop <i>Asymmetries in language: presuppositions and beyond</i>"
        , location = "ZAS Berlin"
        }
      , { title = "Binding back to the future"
        , date = "2019"
        , coauthors = [ "Yasu Sudo" ] : List Text
        , url =
            ResourceUrl.Slides
              "https://patrl.keybase.pub/slides/berlin-cataphora.pdf"
        , event =
            "Talk given at the workshop <i>Asymmetries in language: presuppositions and beyond</i>"
        , location = "ZAS Berlin"
        }
      , { title =
            "Nuclear intervention: deriving Beck effects via cyclic scope and local exhaustification"
        , date = "2019"
        , coauthors = [ "Uli Sauerland" ] : List Text
        , url =
            ResourceUrl.Slides
              "https://patrl.keybase.pub/slides/tuebingen-slides.pdf"
        , event =
            "Talk given at the workshop <i>Exhaustivity in questions and answers - experimental and theoretical approaches</i>"
        , location = "Tübingen"
        }
      , { title = "Movement as higher-order structure building"
        , date = "2019"
        , coauthors = [] : List Text
        , url =
            ResourceUrl.Slides
              "https://patrl.keybase.pub/slides/goettingen-mvt.pdf"
        , event = "Invited talk"
        , location = "Universität Göttingen"
        }
      ]
    : List ../types/Talk.dhall
