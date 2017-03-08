module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

card : { id : String }
card =
    { id = "1"
    }


viewCard : { id : String } -> Html a
viewCard card =
    div []
        [ img [ src "/static/cats/closed.png" ] []
        ]


main =
    viewCard card