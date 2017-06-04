## Level 3 - Beginner Program!

In this section, we will take our first steps toward learning The Elm Architecture (TEA), the architecture that inspired Dan Abramov to create Redux.

We've made it this far without TEA because we have a simple, static app.
Now we want to start responding to user input, and TEA is the way Elm structures applications and handles interactivity.

The goal of the section is to implement card clicking: all cards should start as `Closed`, and change to `Open` when clicked.
Don't worry about `Matched` for now - we'll deal with that later.

[Begin by reading the official docs on `Html.beginnerProgram`](http://package.elm-lang.org/packages/elm-lang/html/1.1.0/Html-App#beginnerProgram)

[You may also find the docs on The Elm Architecture interesting.](https://guide.elm-lang.org/architecture/)

Now that you're getting warm, we will be giving you fewer specific instructions and more high-level requirements. Use the workshop hosts if you have questions and don't forget to make use of the helpfulness of the compiler.

Section outline:

1. Create a helper function `setCard: CardState -> Card -> Card`. As you may have guessed, this function should return a new card with the `state` of the passed card set to the passed `CardState`.
See the docs on [how to update a record](http://elm-lang.org/docs/records#updating-records).
1. Change `main` to `Html.beginnerProgram { ... }`. Read the docs to see what parameters it accepts!
1. Create a type alias `Model` that has the following type: `{ cards : List Card }`
1. Create the union type `Msg` with only one constructor: `CardClick Card`
1. Use pattern matching in `update` on the type of `Msg` and open the clicked card. Note: for now your pattern match expression only has the one case (`CardClick`) but we will add more cases later.
1. Add `import Html.Events exposing (..)` and add an `onClick` event handler on closed cards.

When this section is complete, you should render three closed cards, each of them opening when clicked.

