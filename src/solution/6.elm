module Main exposing (main)

import DeckGenerator
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


viewCard : Card -> Html Msg
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
                , onClick (CardClicked card)
                , src "/cats/closed.png"
                ]
                []

        Matched ->
            img
                [ class "card matched"
                , src ("/cats/" ++ card.id ++ ".png")
                ]
                []


viewCards : Deck -> Html Msg
viewCards cards =
    div [ class "cards" ] (List.map viewCard cards)


setCard : CardState -> Card -> Deck -> Deck
setCard state card deck =
    List.map
        (\c ->
            if c.id == card.id && c.group == card.group then
                { card | state = state }

            else
                c
        )
        deck


isMatching : Card -> Card -> Bool
isMatching c1 c2 =
    c1.id == c2.id && c1.group /= c2.group


closeUnmatched : Deck -> Deck
closeUnmatched deck =
    List.map
        (\c ->
            if c.state /= Matched then
                { c | state = Closed }

            else
                c
        )
        deck


allMatched : Deck -> Bool
allMatched deck =
    List.all (\c -> c.state == Matched) deck


updateCardClick : Card -> GameState -> GameState
updateCardClick clickedCard game =
    case game of
        Choosing deck ->
            let
                updatedDeck =
                    deck
                        |> closeUnmatched
                        |> setCard Open clickedCard
            in
            Matching updatedDeck clickedCard

        Matching deck openCard ->
            let
                updatedDeck =
                    if isMatching clickedCard openCard then
                        deck
                            |> setCard Matched clickedCard
                            |> setCard Matched openCard

                    else
                        setCard Open clickedCard deck
            in
            if allMatched updatedDeck then
                GameOver

            else
                Choosing updatedDeck

        GameOver ->
            game


update : Msg -> Model -> Model
update msg model =
    case msg of
        CardClicked card ->
            { model | game = updateCardClick card model.game }

        RestartGame ->
            init


init : Model
init =
    { game = Choosing GameGenerator.staticDeck }


view : Model -> Html Msg
view model =
    case model.game of
        Choosing deck ->
            viewCards deck

        Matching deck card ->
            viewCards deck

        GameOver ->
            div []
                [ text "You won!"
                , button [ onClick RestartGame ]
                    [ text "Click to restart"
                    ]
                ]


main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
