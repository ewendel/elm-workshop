## Level 1 - Model

When working in a language with a good type system, it is often a good idea to start development by modeling the types that will be used in your program.

We encourage you to take a stab at this yourself first, but we have included one way of doing it below.

You will also need a function that can be used to create a `Map` (the playing field) of a given size.

By the end of this section you should be able to create an initial `Model` for the snake game.

---

#### Example domain model for Snake:

```elm
module Snake.Model
    exposing
        ( Model
        , Msg(..)
        , Direction(..)
        , Snake
        , Food
        , Position
        , Tile(..)
        , Row
        , init
        )


type alias Model =
    { snake : Snake
    , direction : Direction
    , food : Food
    , dead : Bool
    , map : Map
    }


type alias Position =
    ( Int, Int )


type alias Food =
    Maybe Position


type alias Snake =
    { head : Position
    , tail : List Position
    , isGrowing : Bool
    }


type Direction
    = Up
    | Down
    | Left
    | Right


type Tile
    = Wall
    | Open Position


type alias Row =
    List Tile


type alias Map =
    List Row
```

#### Example implementation of creating a `Map`

`createMap` can be implemented by these two helper functions:
* `createRow : Int -> Int -> Row`
* `generateTileAt : Int -> Position -> Tile`.


```elm
createMap : Int -> Map
createMap size =
    List.map (createRow size) (List.range 1 size)


createRow : Int -> Int -> Row
createRow size x =
    List.map (\y -> generateTileAt size ( x, y )) (List.range 1 size)


generateTileAt : Int -> Position -> Tile
generateTileAt size ( x, y ) =
    if x == 1 || y == 1 || x == size || y == size then
        Wall
    else
        Open ( x, y )
```
