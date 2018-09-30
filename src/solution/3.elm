module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


myCard : { id : String }
myCard =
    { id = "1"
    }


viewCard : { id : String } -> Html a
viewCard card =
    div []
        [ img [ src "/cats/closed.png" ] []
        ]


main =
    viewCard myCard
