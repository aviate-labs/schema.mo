let Package = { name : Text, version : Text, repo : Text, dependencies : List Text }
in [
    { name = "std"
    , version = "main"
    , repo = "https://github.com/internet-computer/std.mo"
    , dependencies = [] : List Text
    },
    { name = "testing"
    , version = "v0.1.0"
    , repo = "https://github.com/internet-computer/testing.mo"
    , dependencies = [] : List Text
    }
] : List Package
