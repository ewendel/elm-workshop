module Main exposing (..)

import App exposing (view, init, update, subscriptions)
import Model exposing (Model, Msg)
import Html


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
