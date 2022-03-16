## Level 5 - Let's get random!

You might have noticed that our game is kind of easy; the cards are in the same spots every time, and that's no fun!
We will now make things more interesting by shuffling the deck of cards at the start of each game.

Shuffling a list of something includes randomness, and generating random numbers is an impure operation.
Elm is a _pure_ functional language, and if you look through the type signatures of the functions we have written so far, there is no way to express impurity.
Luckily, there is a way to do exactly that.

> #### Why is generating random numbers impure?
>
> Take for example JavaScript's function `Math.random()`, which produces random floating point numbers. It takes zero arguments and it will (probably) give you a different number back each time you call it.

> From wikipedia:
>
> > random() is impure because each call potentially yields a different value. This is because pseudo-random generators use and update a global "seed" state. If we modify it to take the seed as an argument, i.e. random(seed); then random becomes pure, because multiple calls with the same seed value return the same random number.

To generate something random, we can to use the built-in function

```elm
Random.generate : (a -> msg) -> Generator a -> Cmd msg
```

The `Generator a` part is covered by `DeckGenerator.random : Generator Deck`, so that means you have to supply a function that takes a `Deck` and returns a `Msg`.

Now you're probably wondering what that `Cmd` thingy is, so take a minute and head on over to [elm-tutorial.org](https://www.elm-tutorial.org/en/), which has a nice explanation of [commands](https://www.elm-tutorial.org/en/03-subs-cmds/02-commands.html).

In order to use `Cmd` we need to change our `Browser.sandbox` to `Browser.element`.

There are a couple of changes we have to do to make this official transition from _beginners_ to _adepts_.

-   The argument to `Browser.element` differs slightly from the argument to `Browser.sandbox`:
    1. `init`'s type is now `flags -> (Model, Cmd Msg)` – you can use `()` for `flags`
    2. The record should have a new field called `subscriptions : Model -> Sub Msg`.
-   `update` now has the type signature `update : Msg -> Model -> (Model, Cmd Msg)`

The official docs has a nice explanation of what [_subscriptions_](https://package.elm-lang.org/packages/elm/core/latest/Platform-Sub#Sub) and [_flags_](https://guide.elm-lang.org/interop/flags.html) are.

---

**Task:**

-   Change from `Browser.sandbox` to `Browser.element`
-   Use `Random.generate` together with `DeckGenerator.random` to get a different deck each time the game is started

**Hint:**
In your code you can use `Sub.none` and `Cmd.none` when you don't have any _subscriptions_ or _commands_ you want to perform.

## Game over?

And there you have it! You have now created your own version of a memory game with Elm (and cats)!
