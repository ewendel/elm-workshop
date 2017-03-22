module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)
import String exposing (concat)
import List exposing (map)

-- MODEL

type CardState = Open | Closed | Matched
type alias Card = { id: String, state: CardState }

card1 : Card
card1 =
    { id = "1"
    , state = Closed
    }


card2 : Card
card2 =
    { id = "2"
    , state = Closed
    }


card3 : Card
card3 =
    { id = "3"
    , state = Closed
    }

type alias Model = { cards: List Card}
model : Model
model = { cards = [card1, card2, card3] }

type Msg = CardClick Card

-- UPDATE

update : Msg -> Model -> Model
update msg model =
    case msg of
        CardClick card ->
           { cards = List.map (\c -> if c.id == card.id then setCard Open c else c) model.cards }

-- VIEW

viewCard: Card -> Html Msg
viewCard card =
    case card.state of
        Open ->
            div []
              [ img [ class "open", src  ("/static/cats/" ++ card.id ++ ".jpg") ] [] ]
        Closed ->
            div []
              [ img [ onClick (CardClick card), src  ("/static/cats/closed.png") ] [] ]
        Matched ->
            div []
              [ img [ class "matched",  src  ("/static/cats/" ++ card.id ++ ".jpg") ] [] ]

viewCards: List Card -> Html Msg
viewCards cards = div [] (List.map viewCard cards )

setCard: CardState -> Card -> Card
setCard state card = { card | state = state }

view : Model -> Html Msg
view model = viewCards model.cards

main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }