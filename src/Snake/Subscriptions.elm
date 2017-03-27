module Snake.Subscriptions exposing (subscriptions)

import Time exposing (..)
import Snake.Model exposing (..)
import Keyboard exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    if not model.dead then
        Sub.batch
            [ Time.every (Time.second / 6) (always Tick)
            , Keyboard.downs (keyCodeToMsg model.direction)
            ]
    else
        Sub.none


keyCodeToMsg : Direction -> KeyCode -> Msg
keyCodeToMsg current key =
    case ( current, key ) of
        ( Down, 38 ) ->
            NoOp

        ( Up, 40 ) ->
            NoOp

        ( Right, 37 ) ->
            NoOp

        ( Left, 39 ) ->
            NoOp

        ( _, 38 ) ->
            DirectionChange Up

        ( _, 40 ) ->
            DirectionChange Down

        ( _, 37 ) ->
            DirectionChange Left

        ( _, 39 ) ->
            DirectionChange Right

        ( _, _ ) ->
            NoOp
