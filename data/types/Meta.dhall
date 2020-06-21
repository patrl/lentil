let Content = < Markdown : Text | Org : Text | Plain : Text >

let Meta =
      { metaTitle : Text
      , metaContent : Content
      , metaStyle : Text
      , metaDate : Optional Text
      }

in  Meta
