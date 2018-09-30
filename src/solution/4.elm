module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


type CardState
    = Open
    | Closed
    | Matched


type alias Card =
    { id : String
    , state : CardState
    }


openCard : Card
openCard =
    { id = "1"
    , state = Open
    }


closedCard : Card
closedCard =
    { id = "1"
    , state = Closed
    }


matchedCard : Card
matchedCard =
    { id = "1"
    , state = Matched
    }


viewCard : Card -> Html a
viewCard card =
    img [ src ("/cats/" ++ card.id ++ ".png") ] []


viewCards : List Card -> Html a
viewCards cards =
    div [] (List.map viewCard cards)


main =
    viewCards [ openCard, closedCard, matchedCard ]
