module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { cards : List Card
    }


type Msg
    = CardClicked Card


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


viewCard : Card -> Html Msg
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
                , onClick (CardClicked card)
                , src ("/static/cats/closed.png")
                ]
                []

        Matched ->
            img
                [ class "matched"
                , src ("/static/cats/" ++ card.id ++ ".jpg")
                ]
                []


viewCards : List Card -> Html Msg
viewCards cards =
    div [] (List.map viewCard cards)


setCard : CardState -> Card -> Card
setCard state card =
    { card | state = state }


update : Msg -> Model -> Model
update msg model =
    case msg of
        CardClicked clickedCard ->
            { cards =
                List.map
                    (\c ->
                        if c.id == clickedCard.id then
                            (setCard Open clickedCard)
                        else
                            c
                    )
                    model.cards
            }


view : Model -> Html Msg
view model =
    viewCards model.cards


main =
    Html.beginnerProgram
        { model = { cards = [ openCard, closedCard, matchedCard ] }
        , view = view
        , update = update
        }
