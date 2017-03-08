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


setCard : CardState -> Card -> Deck -> Deck
setCard state card deck =
    (deck
        |> List.map
            (\c ->
                if c.id == card.id && c.group == card.group then
                    { c | state = state }
                else
                    c
            )
    )


closeUnmatched : Deck -> Deck
closeUnmatched =
    List.map
        (\c ->
            if c.state /= Matched then
                { c | state = Closed }
            else
                c
        )


allMatched : Deck -> Bool
allMatched deck =
    deck |> List.all (\c -> c.state == Matched)


updateCardClick : Card -> GameState -> GameState
updateCardClick clickedCard state =
    case state of
        NotStarted ->
            state

        Choosing deck ->
            let
                updatedDeck =
                    deck
                        |> closeUnmatched
                        |> setCard Open clickedCard
            in
                Matching
                    updatedDeck
                    clickedCard

        Matching deck openCard ->
            let
                updatedDeck =
                    if clickedCard.id == openCard.id && clickedCard.group /= openCard.group then
                        deck
                            |> setCard Matched clickedCard
                            |> setCard Matched openCard
                    else
                        setCard Open clickedCard deck
            in
                if allMatched updatedDeck then
                    GameOver deck
                else
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
    "/static/cats/"


viewCard : Card -> Html Msg
viewCard card =
    case card.state of
        Closed ->
            li [ class "card" ]
                [ img
                    [ src (imgUrlPrefix ++ "question-mark.png")
                    , width 200
                    , height 200
                    , onClick (CardClick card)
                    ]
                    []
                ]

        _ ->
            li [ class "card open" ]
                [ img [ src (imgUrlPrefix ++ card.id ++ ".jpg") ] []
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
