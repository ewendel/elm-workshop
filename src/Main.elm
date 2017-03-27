module Main exposing (..)

import Memory.Model
import Memory.Main as Memory
import Snake.Model
import Snake.Subscriptions
import Snake.Update
import Snake.View
import Html exposing (..)
import Html.Events exposing (..)


type Game
    = None
    | Memory
    | Snake


type Msg
    = MainMenuClick
    | MemoryClick
    | SnakeClick
    | MemoryMsg Memory.Model.Msg
    | SnakeMsg Snake.Model.Msg


type alias Model =
    { game : Game
    , memoryModel : Memory.Model.Model
    , snakeModel : Snake.Model.Model
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MainMenuClick ->
            ( model, Cmd.none )

        MemoryClick ->
            let
                ( m, c ) =
                    Memory.init
            in
                ( { model
                    | game = Memory
                    , memoryModel = m
                  }
                , Cmd.map MemoryMsg c
                )

        SnakeClick ->
            let
                ( m, c ) =
                    Snake.Model.init
            in
                ( { model
                    | game = Snake
                    , snakeModel = m
                  }
                , Cmd.map SnakeMsg c
                )

        MemoryMsg subMsg ->
            let
                ( m, c ) =
                    Memory.update subMsg model.memoryModel
            in
                ( { model
                    | memoryModel = m
                  }
                , Cmd.map MemoryMsg c
                )

        SnakeMsg subMsg ->
            let
                ( m, c ) =
                    Snake.Update.update subMsg model.snakeModel
            in
                ( { model
                    | snakeModel = m
                  }
                , Cmd.map SnakeMsg c
                )


viewMainMenu : Html Msg
viewMainMenu =
    div []
        [ h1 [] [ text "Choose game" ]
        , button [ onClick MemoryClick ] [ text "Memory" ]
        , button [ onClick SnakeClick ] [ text "Snake" ]
        ]


view : Model -> Html Msg
view model =
    case model.game of
        None ->
            viewMainMenu

        Memory ->
            Html.map MemoryMsg <| Memory.view model.memoryModel

        Snake ->
            Html.map SnakeMsg <| Snake.View.view model.snakeModel


init : ( Model, Cmd Msg )
init =
    ( { game = None
      , memoryModel = Tuple.first Memory.init
      , snakeModel = Tuple.first Snake.Model.init
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.game of
        None ->
            Sub.none

        Memory ->
            Sub.map MemoryMsg <| Memory.subscriptions model.memoryModel

        Snake ->
            Sub.map SnakeMsg <| Snake.Subscriptions.subscriptions model.snakeModel


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
