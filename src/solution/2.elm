module Main exposing (main)

import Html exposing (..)


prefix : String
prefix =
    "Welcome to our humble establishment, "


greet : String -> Html a
greet name =
    text (prefix ++ name)


main =
    greet "World"
