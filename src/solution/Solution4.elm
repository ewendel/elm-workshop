module Solution.Solution4 exposing (main)

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


viewCard : Card -> Html msg
viewCard card =
    case card.state of
        Open ->
            img
                [ class "card open"
                , src ("/cats/" ++ card.id ++ ".png")
                ]
                []

        Closed ->
            img
                [ class "card closed"
                , src "/cats/closed.png"
                ]
                []

        Matched ->
            img
                [ class "card matched"
                , src ("/cats/" ++ card.id ++ ".png")
                ]
                []


viewCards : List Card -> Html msg
viewCards cards =
    div [] (List.map viewCard cards)


main : Html msg
main =
    viewCards [ openCard, closedCard, matchedCard ]
