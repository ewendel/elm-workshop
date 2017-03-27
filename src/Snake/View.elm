module Snake.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Snake.Model exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ text "Snake"
        , if model.dead then
            div [] [ text "Game over!", button [ onClick RestartGame ] [ text "Click to restart" ] ]
          else
            div [ class "map" ] (List.map (viewRow model.snake model.food) model.map)
        ]


viewRow : Snake -> Food -> Row -> Html Msg
viewRow snake food row =
    div [ class "row" ] (List.map (viewTile snake food) row)


viewTile : Snake -> Food -> Tile -> Html Msg
viewTile snake food tile =
    let
        className =
            getTileClass snake food tile
    in
        span [ class (className ++ " tile") ] []


getTileClass : Snake -> Food -> Tile -> String
getTileClass snake food tile =
    case tile of
        Wall ->
            "wall"

        Open pos ->
            if pos == snake.head || List.any ((==) pos) snake.tail then
                "snake"
            else if Just pos == food then
                "food"
            else
                "open"
