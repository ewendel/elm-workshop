## Task 1 - Hello, world!
File: Main.elm

Code is not compiling - need HTML, not `String`.
1. Create text node with the `text` function - it takes a `String` and returns some HTML
1. Create a function `greet` that has the signature `greet : String -> Html a`
  * Strings are concatenated by `++`
  * `greet "my name"` should output `Hello, my name` to the screen
1. Move the `Hello, ` prefix to a value, use it in `greet`
1. Add type signatures

## Task 2 - types!
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

## Task 3 - Beginner program!
1. Create a type alias called `Model` with a field `cards : List Card`
1. Create the type `Msg` that has just a `CardClick Card`
1. Create a function `update : Msg -> Model -> Model` that just returns the model it's passed
1. Create function `view : Model -> Html a` that calls `viewCards`
1. Change `main` to `Html.beginnerProgram { ... }`
1. Create `setCard : CardState -> Card -> Card` -> `{ card | state = state }`
1. Pattern match on `msg` in `update`. Open the clicked card.
1. Add `onClick (CardClick card)` on the closed card

## Task 4 - The game!
1. `type alias Deck = List Card`
1. `type Group = A | B`
1. Add `group : Group` to `Card`
1. Update `Model` to have `deck`
1. Move all types to file `Model.elm`
  * Remember to expose them
1. Add file `GameGenerator.elm` with the following contents:

### GameGen

```elm
module GameGenerator exposing (staticDeck, randomDeck)

staticDeck : Deck
staticDeck =
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

generateDeck : Random.Generator Deck
generateDeck =
    staticDeck
        |> Random.List.shuffle
```

1. Use `GameGenerator.staticDeck` as model's initial value
1. Have fun clicking cards for about 20 minutes.

## Task 5 - The game 2
1. Add `type GameState = Choosing Deck | Matching Deck Card | GameOver`
1. Change `Model` to `{ game : GameState }` and `init` to `{ game = Choosing GameGenerator.staticDeck }`
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

## Task 6 - Side effects and randomness
