module Solution.Solution3 exposing (main)

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


main : Html a
main =
    viewCard myCard
