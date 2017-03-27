module Snake.Update exposing (update)

import Snake.Model exposing (..)
import Random exposing (Generator, generate, int, pair)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DirectionChange direction ->
            ( { model | direction = direction }, Cmd.none )

        Tick ->
            let
                newModel =
                    performMove model

                command =
                    if newModel.food == Nothing then
                        List.length newModel.map
                            |> randomPosition
                            |> generate PlaceFood
                    else
                        Cmd.none
            in
                ( newModel, command )

        RestartGame ->
            init

        PlaceFood pos ->
            ( { model | food = Just pos }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


randomPosition : Int -> Generator ( Int, Int )
randomPosition size =
    pair (int 2 (size - 1)) (int 2 (size - 1))


performMove : Model -> Model
performMove model =
    let
        newSnake =
            nextSnake model.food model.direction model.snake

        foundFood =
            Just newSnake.head == model.food

        mapSize =
            List.length model.map

        dead =
            let
                ( x, y ) =
                    newSnake.head

                hitWall : Position -> Bool
                hitWall ( x, y ) =
                    x == 1 || y == 1 || x == mapSize || y == mapSize

                hitTail : Snake -> Bool
                hitTail snake =
                    List.any (\t -> t == snake.head) snake.tail
            in
                if hitWall newSnake.head || hitTail newSnake then
                    True
                else
                    False
    in
        { model
            | snake = newSnake
            , food =
                if foundFood then
                    Nothing
                else
                    model.food
            , dead = dead
        }


nextSnake : Food -> Direction -> Snake -> Snake
nextSnake food direction snake =
    let
        nextHead =
            nextPosition direction snake.head
    in
        { snake
            | head = nextHead
            , tail = moveTail snake
            , isGrowing = Just nextHead == food
        }


nextPosition : Direction -> Position -> Position
nextPosition direction ( x, y ) =
    case direction of
        Up ->
            ( x - 1, y )

        Down ->
            ( x + 1, y )

        Left ->
            ( x, y - 1 )

        Right ->
            ( x, y + 1 )


moveTail : Snake -> List Position
moveTail snake =
    snake.head
        :: (List.take
                ((List.length snake.tail)
                    - (if snake.isGrowing then
                        0
                       else
                        1
                      )
                )
                snake.tail
           )
