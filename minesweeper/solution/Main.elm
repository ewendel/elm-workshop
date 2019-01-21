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
    { state : GameState
    , board : Board
    , seconds : Int
    }


type alias Board =
    List Cell


type alias Cell =
    { cellState : CellState
    , cellType : CellType
    }


type GameState
    = NotStarted
    | Playing
    | Lost
    | Won


type CellState
    = Open
    | Closed
    | Flagged


type CellType
    = Mine
    | Safe Int


type Msg
    = OpenCell Int
    | FlagCell Int
    | UnflagCell Int
    | StartNewGame
    | NewGame Board
    | Tick


columns : Int
columns =
    16


rows : Int
rows =
    16


mines : Int
mines =
    40


countFlags : Board -> Int
countFlags board =
    board
        |> List.filter (.cellState >> (==) Flagged)
        |> List.length


createBoard : Generator Board
createBoard =
    let
        mineCells =
            List.repeat mines Mine

        safeCells =
            List.repeat (columns * rows - mines) (Safe 0)

        updateHints cells =
            let
                countSurroundingMines index cell =
                    case cell of
                        Mine ->
                            Mine

                        Safe _ ->
                            neighbours index
                                |> List.filterMap (\a -> List.Extra.getAt a cells)
                                |> List.filter ((==) Mine)
                                |> List.length
                                |> Safe
            in
            List.indexedMap countSurroundingMines cells
    in
    Random.List.shuffle (safeCells ++ mineCells)
        |> Random.map updateHints
        |> Random.map (List.map (Cell Closed))


init : ( Model, Cmd Msg )
init =
    let
        emptyBoard =
            List.map (Cell Open) <| List.repeat (columns * rows) (Safe 0)
    in
    ( { state = NotStarted
      , board = emptyBoard
      , seconds = 0
      }
    , Random.generate NewGame createBoard
    )


setState : CellState -> Cell -> Cell
setState cellState cell =
    { cell | cellState = cellState }


neighbours : Int -> List Int
neighbours index =
    let
        toIndex ( c, r ) =
            r * columns + c

        ( col, row ) =
            ( modBy columns index
            , index // columns
            )

        removeIllegal (( c, r ) as pos) =
            if c >= columns || c < 0 || r > rows || r < 0 then
                Nothing

            else
                Just pos
    in
    [ ( col - 1, row - 1 )
    , ( col - 1, row + 0 )
    , ( col - 1, row + 1 )
    , ( col + 0, row - 1 )
    , ( col + 0, row + 0 )
    , ( col + 0, row + 1 )
    , ( col + 1, row - 1 )
    , ( col + 1, row + 0 )
    , ( col + 1, row + 1 )
    ]
        |> List.filterMap removeIllegal
        |> List.map toIndex


cellEmpty : Int -> List Cell -> Bool
cellEmpty index model =
    model
        |> List.Extra.getAt index
        |> Maybe.map (\cell -> cell.cellType == Safe 0)
        |> Maybe.withDefault False


cellFlagged : Int -> List Cell -> Bool
cellFlagged index model =
    model
        |> List.Extra.getAt index
        |> Maybe.map (\cell -> cell.cellState == Flagged)
        |> Maybe.withDefault False


openCell : Int -> Board -> Board
openCell index model =
    let
        getIndicesToOpen newIndex acc =
            if List.member newIndex acc then
                acc

            else if cellFlagged newIndex model then
                acc

            else if not <| cellEmpty newIndex model then
                newIndex :: acc

            else
                List.foldl getIndicesToOpen
                    (newIndex :: acc)
                    (neighbours newIndex)

        indices =
            getIndicesToOpen index []
    in
    List.Extra.updateIfIndex
        (\a -> List.member a indices)
        (setState Open)
        model


flagCell : Int -> Board -> Board
flagCell index model =
    List.Extra.updateAt index (setState Flagged) model


unflagCell : Int -> Board -> Board
unflagCell index model =
    List.Extra.updateAt index (setState Closed) model


openAllMines : Board -> Board
openAllMines =
    List.map
        (\cell ->
            if cell.cellType == Mine then
                { cell | cellState = Open }

            else
                cell
        )


updateGameState : Model -> Model
updateGameState model =
    let
        detonatedMines =
            model.board
                |> List.filter (.cellType >> (==) Mine)
                |> List.filter (.cellState >> (==) Open)
                |> (not << List.isEmpty)

        allEmptyRevealed =
            model.board
                |> List.filter (.cellType >> (/=) Mine)
                |> List.filter (.cellState >> (==) Closed)
                |> List.isEmpty
    in
    if detonatedMines then
        { model
            | state = Lost
            , board = openAllMines model.board
        }

    else if allEmptyRevealed then
        { model | state = Won }

    else
        model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartNewGame ->
            init

        NewGame board ->
            ( { model | board = board }, Cmd.none )

        Tick ->
            ( { model | seconds = model.seconds + 1 }
            , Cmd.none
            )

        OpenCell index ->
            let
                newModel =
                    { model
                        | board = openCell index model.board
                        , state = Playing
                    }
            in
            ( newModel |> updateGameState
            , Cmd.none
            )

        FlagCell index ->
            ( { model | board = flagCell index model.board }, Cmd.none )

        UnflagCell index ->
            ( { model | board = unflagCell index model.board }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "game" ]
        [ div [ class "game-info" ]
            [ div [ class "game-info--mines" ]
                [ text << String.fromInt <| mines - countFlags model.board
                ]
            , button
                [ class "game-info--state"
                , onClick StartNewGame
                ]
                [ text <|
                    case model.state of
                        NotStarted ->
                            ":)"

                        Playing ->
                            ":)"

                        Won ->
                            "B)"

                        Lost ->
                            ":("
                ]
            , div [ class "game-info--time" ]
                [ text << String.fromInt <| model.seconds ]
            ]
        , div
            [ class <|
                "board "
                    ++ (case model.state of
                            NotStarted ->
                                "game--playing"

                            Playing ->
                                "game--playing"

                            Won ->
                                "game--finished"

                            Lost ->
                                "game--finished"
                       )
            , style "width" (String.fromInt (columns * 20) ++ "px")
            ]
            (List.indexedMap (viewCell model.state) model.board)
        ]


viewCell : GameState -> Int -> Cell -> Html Msg
viewCell gameState index cell =
    case cell.cellState of
        Flagged ->
            button
                [ class "cell cell--closed cell--flagged"
                , onRightClick <| UnflagCell index
                ]
                [ text "!" ]

        Closed ->
            button
                [ class "cell cell--closed"
                , onClick <| OpenCell index
                , onRightClick <| FlagCell index
                , disabled <| List.member gameState [ Won, Lost ]
                ]
                [ text "" ]

        Open ->
            case cell.cellType of
                Mine ->
                    button
                        [ class "cell cell--open cell--mine"
                        , disabled True
                        ]
                        [ text "*" ]

                Safe number ->
                    button
                        [ class <| "cell cell--open cell--free-" ++ String.fromInt number
                        , disabled True
                        ]
                        [ if number > 0 then
                            text <| String.fromInt number

                          else
                            text ""
                        ]


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
    case model.state of
        NotStarted ->
            Sub.none

        Playing ->
            Time.every 1000 (always Tick)

        Won ->
            Sub.none

        Lost ->
            Sub.none


onRightClick : Msg -> Attribute Msg
onRightClick message =
    Html.Events.custom
        "contextmenu"
        (Json.Decode.succeed
            { message = message
            , stopPropagation = True
            , preventDefault = True
            }
        )
