
let helloRaw = ./hello.txt as Text

in    λ ( record
        : { name : Text, value : Double, taxed_value : Double, in_ca : Bool }
        )
    → helloRaw
