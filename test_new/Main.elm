module Main exposing (main)

import Addon


main : String -> String
main input =
    input ++ "hello world" ++ Addon.add2 3
