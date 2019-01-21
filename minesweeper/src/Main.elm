module Main exposing (main)

import Browser
import Debug
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Value)
import List.Extra
import Random exposing (Generator)
import Random.List
import Time


type alias Model =
    {}


type Msg
    = NoOp


columns : Int
columns =
    16


rows : Int
rows =
    16


mines : Int
mines =
    40


init : ( Model, Cmd Msg )
init =
    ( {}
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    text "MINESWEEPER"


main : Program Value Model Msg
main =
    Browser.element
        { view = view
        , init = always init
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
