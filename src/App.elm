module App exposing (init, update, view, subscriptions)

import GameGenerator
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Random


init : ( Model, Cmd Msg )
init =
    ( { game = NotStarted }, Cmd.none )


setCardOpen : Bool -> Card -> Deck -> Deck
setCardOpen open card deck =
    (deck
        |> List.map
            (\c ->
                if c.id == card.id && c.group == card.group then
                    { c | open = open }
                else
                    c
            )
    )


matchCards : Card -> Card -> Bool
matchCards c1 c2 =
    c1.id == c2.id && c1.group /= c2.group


updateCardClick : Card -> GameState -> GameState
updateCardClick clickedCard state =
    case state of
        NotStarted ->
            state

        Choosing deck ->
            Matching
                (setCardOpen True clickedCard deck)
                clickedCard

        Matching deck openCard ->
            let
                updatedDeck =
                    if matchCards clickedCard openCard then
                        (setCardOpen True clickedCard deck)
                    else
                        (setCardOpen False openCard deck)
            in
                Choosing updatedDeck

        GameOver deck ->
            state


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartGameClick ->
            ( model
            , Random.generate DeckGenerated GameGenerator.generateDeck
            )

        DeckGenerated deck ->
            ( { model | game = Choosing deck }, Cmd.none )

        CardClick card ->
            ( { model | game = updateCardClick card model.game }
            , Cmd.none
            )

        GameTimeout ->
            ( model, Cmd.none )


imgUrlPrefix : String
imgUrlPrefix =
    "http://lorempixel.com/200/200/cats/"


viewCard : Card -> Html Msg
viewCard card =
    if card.open then
        li [ class "card open" ]
            [ text (toString card) ]
        -- [ img [ src (imgUrlPrefix ++ card.id) ] []
        -- ]
    else
        li [ class "card" ]
            [ img
                [ src (imgUrlPrefix ++ "13337")
                , onClick (CardClick card)
                ]
                []
            ]


viewCards : Deck -> Html Msg
viewCards deck =
    ul [ class "cards" ]
        (deck |> List.map viewCard)


viewPlaying : Deck -> Html Msg
viewPlaying deck =
    div [ class "game" ]
        [ h1 [] [ text "GAME" ]
        , viewCards deck
        ]


viewGameStarter : Html Msg
viewGameStarter =
    div [ onClick StartGameClick ] [ text "START GAME" ]


viewWon : Score -> Html Msg
viewWon score =
    div [] [ text ("A winrar is you! " ++ (toString score) ++ " points") ]


view : Model -> Html Msg
view model =
    div []
        [ img [] []
        , case model.game of
            NotStarted ->
                viewGameStarter

            Choosing deck ->
                viewPlaying deck

            Matching deck card ->
                viewPlaying deck

            GameOver deck ->
                viewWon 0
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
