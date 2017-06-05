## Level 4 - The game!

In memory, as you may know, the player opens two cards, one after another, and if they match they stay open.
If they do not match, both cards are closed again.
This repeats until all cards on the board are open. Before we start implementing the game logic, let's clean up a bit.

Our deck of cards is a list of `Card`s and we will be passing them around in our program.
Therefore, instead of having to write `List Card` everywhere, we want to be able to write `Deck`. Use a type alias to achieve this.

In the game we will be matching pairs of cards with each other, and will need some way to distinguish between two cards with the same image.
We will do this by saying that a card can be _either_ in group `A` or in group `B`. Use a union type to achieve this, and add it as a field in our `Card` type.

Now we can check if two cards are of one pair by comparing their `id` and `group` fields!

By now our `Main.elm` file is getting quite big, so we should probably do something about that.
It is common in Elm projects to have the application's model and associated in their own file(s), so let's try that:

1. Move all types and type aliases to the file `Model.elm`
    * A module's name must match it's file name, so in our case `Model.elm` should start with `module Model exposing (..)`
1. To use our types in `Main.elm` we also need to import them. This is done in the same way as we import the `Html` module; `import Html exposing (..)`


Let's pretend we're famous TV chefs and cheat a little bit. We have prepared a module `DeckGenerator` that can be used to generate a deck of cards.
Use this by importing `DeckGenerator` in `Main.elm` and using the `DeckGenerator.static` value as `model`'s initial value.

### Game logic!
Our game implementation will have three states:

  1. `Choosing` - the player chooses the first card
  1. `Matching` - the player chooses the second card to match with the first
  1. `GameOver` - all cards are matched and the player has won

The game logic will flow like this:

  1. When the player chooses the first card he is in the `Choosing` state:
      1. Set all unmatched cards to `Closed`
      1. Set the chosen/clicked card to `Open`
      1. Go to `Matching` state
  1. In the `Matching` state, the player chooses his second card:
      1. If it matches the first card, then set the two cards to `Matched`. If the two cards do not match, set the clicked card to `Open`.
  1. If all cards are `Matched`, then go to `GameOver` state, else go to `Choosing` state

Start by implementing the three states as a union type called `GameState`.
The `GameOver` state does not need any extra data, but `Choosing` needs a `Deck` (the deck we are choosing from), and `Matching` needs both a `Deck` (the deck we are choosing from) and a `Card` (the card we are trying to match with).

The `Model` of our program should now change from consisting of just a `Deck` to being a `GameState`. Continue by creating a `updateCardClick` function that can handle the three different `GameState`s.  It should have the following signature:
`updateCardClick : Card -> GameState -> GameState`.

To complete the game logic you will need yo update your `update` and `view` functions to accommodate for the new shape of our model.

Now take a minute and pat yourself on the back for making an awesome game in Elm!

>#### Optional:

>Refreshing the page every time you want to play another game is boring, so try to add a "restart game" button in the "Game over" view. Hint: it is common to have a top-level value called `init` that contains the initial state of the `model`.

