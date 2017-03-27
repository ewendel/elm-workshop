# Round Two - Snake

This will be a pretty open task.
If you want to just dive in and try to figure it out all by yourself, go ahead!

If not, we will guide you some of the way.

## Level 1 - Model

When working in a language with a good type system, it is often a good idea to start development by modeling the types that will be used in your program.

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


In addition to this, we will need a function to create a `Map` of a given size (`createMap : Int -> Map`).
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

With this in place we can create an initial `Model`.
Just fill in some fitting values.

## Level 2 - View

If we have a `Model` we can also create our view function!
Recall that it should have the signature: `view : Model -> Html a`.

The HTML structure we want is this:

```html
<div class="map">
  <div class="row">
    <span class="tile {TILECLASSNAME}" />
    <span class="tile {TILECLASSNAME}" />
    ...
  </div>
  <div class="row">
    <span class="tile {TILECLASSNAME}" />
    <span class="tile {TILECLASSNAME}" />
    ...
  </div>
  ...
</div>
```
where `{TILECLASSNAME}` should be one of theses:
* `snake`
* `food`
* `wall`
* `open`

This is, of course, when when the snake is alive.
If not, you should show some nice message and a button for restarting the game.

## Level 3 - ???

Since we have a model and a view, we only need interactivity in the form of `update` and `subscriptions`.

We need to subscribe to two things:
1. Keyboard presses
1. Ticks at some interval for our game loop

Remember also that the `subscriptions` function takes the current model as an argument, so if the snake is dead there is no need to subscribe to anything!

The following functions will prove useful
* `Keyboard.downs : (Keyboard.KeyCode -> msg) -> Sub msg`
* `Time.every : Time.Time -> (Time.Time -> msg) -> Sub msg`
* `Time.second : Time.Time`

`Keyboard.KeyCode` is an alias for `Int`.

`KeyCode` | Button
----------|--------
37        | Left
38        | Up
39        | Right
40        | Down

* Create the `Msg` type
* Create the `update` function
* Create the `subscriptions` function

## Level 4 - Profit!
