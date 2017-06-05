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

