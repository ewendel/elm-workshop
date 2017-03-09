## Level 1 - Hello, world!
File: Main.elm

Main.elm should look like this:
```elm
module Main exposing (..)

import Html exposing (..)

main = "Hello, world!"
```

Code is not compiling! - need some HTML, not `String`.
1. Create text node with the `text` function - it has the signature `text : String -> Html a`
1. Create a function `greet` that has the signature `greet : String -> Html a`
  * `greet "my name"` should output `Hello, my name` to the screen
  * Strings are concatenated by `++`
1. Move the `Hello, ` prefix to a value, use it in `greet`
1. Add type signatures

## Level 2 - types!
1. Create a value `card` that has property `id` = "1" - it's a new record!
1. Add it's type annotation
1. Create function `viewCard : { id : String } -> Html a` -> return its `id`
1. Call `viewCard` from `main` with `card`
1. Instead of returning the card's `id`, return an `img` with `src "/static/closed.png"
1. Create union type `CardState = Open | Closed | Matched`
1. Add `state : CardState` in for `card` usages
1. Create `type alias` for `Card`, use it for `card` and `viewCard`
1. Rename `card` to `openCard`; add `closedCard` and `matchedCard`
1. Create `viewCards : List Card -> Html a`
  * `List.map viewCard cards`
1. Call `viewCards` with `[ openCard, closedCard, matchedCard ]`
1. In `viewCard`; pattern match on `card.state`
  * For `Closed`, show "/static/closed.png"
  * For `Open` and `Matched`, show "/static/cats/{cardId}.png"
1. Add the respective css classes `open`, `closed` and `matched`

## Level 3 - Beginner program!
1. Create a type alias called `Model` with a field `cards : List Card`
1. Create the type `Msg` that has just a `CardClick Card`
1. Create a function `update : Msg -> Model -> Model` that just returns the model it's passed
1. Create function `view : Model -> Html a` that calls `viewCards`
1. Change `main` to `Html.beginnerProgram { ... }`
1. Create `setCard : CardState -> Card -> Card` -> `{ card | state = state }`
1. Pattern match on `msg` in `update`. Open the clicked card.
1. Add `onClick (CardClick card)` on the closed card

## Level 4 - The game!

We are now going to implement our game logic.

In memory, as you may know, the player opens two cards, and if they match they stay open.
If they do not match, both cards are closed again.
This repeats until all cards on the board are open.

Our game implementation will have three states:
  1. `Choosing` - the player chooses the first card
  1. `Matching` - the player chooses the second card to match with the first
  1. `GameOver` - all cards are matched and the player has won

The game logic will flow like this:
  1. When the player chooses the first card:
    1. Set all unmatched cards to `Closed`
    1. Set the chosen card to `Open`
    1. Go to `Matching` state
  1. When the player chooses the second card:
    1. ```
    If it matches the first card, then set the two cards to `Matched`
    Else set the second card to `Open`
    ```
    1. ```
    If all cards are `Matched`, then go to `GameOver` state
    Else go to `Choosing` state
    ```

Let's get back to the code.

Our deck of cards is a list of `Card`s and we will be passing them around in our program.
Therefore, instead of having to write `List Card` everywhere, we want to be able to write `Deck`.
1. Create a `type alias` for `List Card` called `Deck`
1. Update `Model` to have `deck`

In the game we will be matching pairs of cards with eachother, and will need some way of distinguish between to cards with the same image.

1. Create a type `Group` that is either `A` or `B`
1. Add that as a field in our `Card` type

Now we are able to check if two cards are of one pair by comparing their `id` and `group` fields!

By now our `Main.elm` file is getting quite big, so we should probably do something about that.
It is common in Elm projects to have the application's models in their own file, so let's try that:
1. Move all types and type aliases to a new file: `Model.elm`
  * A file and it's module name must match, so in our case `Model.elm` should start with `module Model exposing (..)`
1. To use our types in `Main.elm` we also need to import them. This is done in the same way as we import the `Html` module; `import Html exposing (..)`


Let's pretend we're famous TV chefs and cheat a little bit. We have prepared a module `DeckGenerator` that can be used to generate a deck of cards.

1. Add file `DeckGenerator.elm` with the following contents:

```elm
module DeckGenerator exposing (static, random)

import Random
import Random.List
import Model exposing (Deck, CardState(..), Group(..))

static : Deck
static =
    let
        urls =
            [ "1"
            , "2"
            , "3"
            , "4"
            , "5"
            , "6"
            ]

        groupA =
            urls |> List.map (\id -> { id = id, state = Closed, group = A })

        groupB =
            urls |> List.map (\id -> { id = id, state = Closed, group = B })
    in
        List.concat [ groupA, groupB ]

random : Random.Generator Deck
random =
    Random.List.shuffle static
```

Use this by importing `DeckGenerator` in `Main.elm` and using the `static` value as `model`'s initial value.

Have fun clicking cards for about 20 minutes.


## Level 5 - The game 2

Let's now implement the game logic!

As we've established, our game has three states: `Choosing`, `Matching` and `GameOver`.
Let's implement this as a union type called `GameState`.

The `GameOver` state does not need any extra data, but `Choosing` needs a `Deck` (the deck we are choosing from), and `Matching` needs both a `Deck` (the deck we are choosing from) and a `Card` (the card we are trying to match with).

1. Add `type GameState = Choosing Deck | Matching Deck Card | GameOver`
1. Change `Model` to `{ game : GameState }` and `init` to `{ game = Choosing DeckGenerator.static }`
1. Change `view` to accommodate this; just return whatever in whatever
1. Create function `updateCardClick : Card -> GameState -> GameState`
  * Only worry about `Choosing` branch -> Next `GameState` is `Matching`
1. Call `updateCardClick` from the `update` function
1. Change `setCard` to `setCard : CardState -> Card -> Deck -> Deck`
  * `if c.id == card.id && c.group == card.group then`....
  * Use this from `updateCardClick`
1. Create `isMatching : Card -> Card -> Bool`
1. Create `closeUnmatched : Deck -> Deck`
1. Create `allMatched : Deck -> Bool`
  * (`List.all`)
1. Implement the `Matching` branch in `updateCardClick`
  * When the two cards match (`isMatching`), set both cards to `Matched` (PIPELINE)
  * When the two cards do not match, set the second card to `Open`
  * Go to `Choosing` state
1. In `Choosing` state, close all unmatched cards before opening the clicked card
1. In `Matching`, if all cards match after updating deck, go to `GameOver`
1. In the "game over" view, congratulate the user and add a button that restarts the game
1. Move the game's initial state to a value `init : Model`
1. On "restart button click" set the model to `init`

## Level 6 - Side effects and randomness
1. Change `beginnerProgram` to `program`
  * Rename `model` to `init`
  * Add `subscriptions = \_ -> Sub.none`
  * Change `init` and `update` according to new type sigs (`Cmd.none`)
1. Add new constructor for `Msg`; `DeckGenerated Deck`
1. When starting the game, return the command `Random.generate DeckGenerated DeckGenerator.random`


## Bonus levels
1. Count the number of attempts the player uses, use that as score
1. Count how long the player takes to finish the game. Use [Time.now](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Time#now) together with [Task.perform](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Task#perform) to get the current time
