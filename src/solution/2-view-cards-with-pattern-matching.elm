module Main exposing (..)

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
    { id = "2"
    , state = Closed
    }


matchedCard : Card
matchedCard =
    { id = "3"
    , state = Matched
    }


viewCard : Card -> Html msg
viewCard card =
    case card.state of
        Open ->
            img
                [ class "open"
                , src ("/static/cats/" ++ card.id ++ ".jpg")
                ]
                []

        Closed ->
            img
                [ class "closed"
                , src ("/static/cats/closed.png")
                ]
                []

        Matched ->
            img
                [ class "matched"
                , src ("/static/cats/" ++ card.id ++ ".jpg")
                ]
                []


viewCards : List Card -> Html a
viewCards cards =
    div [] (List.map viewCard cards)


main =
    viewCards [ openCard, closedCard, matchedCard ]




