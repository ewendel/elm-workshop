# Elm Arcade
# Getting Started With Elm and Typed Functional Programming

Welcome to this workshop! Today we're learning Elm and basic functional programming techniques from the ML-language family through creating the classic game Memory.

The workshop will cover the following topics:

* Tuples
* Records
* Type Inference
* Type Signatures (Hindley-Milner type system)
* Union Types
* Type Aliases
* Pattern Matching
* Functions
* Partial Application
* Currying

Some of these concepts may be unfamiliar and somewhat confusing to begin with, but please do ask us if and when you get stuck, or simply have a question. That's what we're here for!

## Prerequisites

We hope you've already done the following:

1. Clone this repo to your computer

2. Install `elm`. This can be done with `npm`, `brew` or an old-school file download from elm-lang.org.

3. Install `elm-format`. This is a really crucial tool to make your learning experience more enjoyable. ([github.com/avh4/elm-format#for-elm-018]())

4. At the time of writing, Atom has the best Elm addons around, namely [Elmjutsu](https://atom.io/packages/elmjutsu). You really should install it if you're on Atom, or perhaps consider Atom for your Elm career.

If not, please at least do step one, two and three.

Before we begin, start your local application enviroment with `npm start` in the root folder. This should open a new browser window with `localhost:3000`.

## Level 1 - Hello, world!
File: _Main.elm_

Main.elm should look like this:
```elm
module Main exposing (..)

import Html exposing (..)

main = "Hello, world!"
```

As you can see in your browser, the app will fill the screen with an error message if your code does not compile. This is a big difference between JavaScript and Elm! You will have to run your JavaScript code in the browser to discover any programming mistakes, while Elm will simply not compile with errors.

Read the error message on screen.

The creators of Elm have put a lot of energy into creating helpful error messages that guide towards solving the problem.

Our app is now telling us that the value of `main` has the wrong type: it is a `String` but it should be either `Html`, `Svg` or `Program`.

To change the String into Html we'll need to call a function that does exactly that:

`text "I am going to be a HTML text node, hooray!"`
#### Function calls in Elm

Unlike JavaScript, Elm uses

* a space between function name and argument list, not parens
* spaces between arguments, not commas

```elm
// JavaScript
add(2,3) == 5

-- Elm
add 2 3 == 5
```

This means that calling our `text` function in JavaScript would look something like this:

`text("I am going to be a HTML node, hooray!")`

In terms of types, which is a huge part of Elm, `text` has the following _type signature_:

[text: String -> Html](http://package.elm-lang.org/packages/evancz/elm-html/4.0.1/Html#text)

The colon means "has the type", so the line reads as _"text has the type string to html"_.

Clicking the link takes you the documentation.
Now you should be able to see "Hello World" printed on the screen.

### Creating a greeting function

Now we want to create a function that takes a name and greets. It has this type signature:
`greet: String -> String`

Called with "Erik", it should produce the string "Hello, Erik". Thus:

`greet "Erik" == "Hello, Erik"`

Here is an example of a function that takes two numbers and returns the sum of those numbers:

```
add x y =
	x + y
```

There are several things to note here:

* There's no `return` keyword - the evaluated value of the function body is automatically returned
* The parameters are named and follows the function name
* You don't have to specify the types for the parameters - they are _inferred_! This can be done because Elm sees the addition operator (`+`) and knows that it only works on numbers. Therefore, x and y must be numbers!

Go ahead and make the `greet` function. The string concatenation operator in Elm is `++`

### A prefix binding

When you got that part down, lets move the prefix into a variable so that it can be reused later.
Creating a variable, or binding as they are called in Elm, is similar to a function with _zero_ arguments. Try it out!

### Adding type signatures

Before we finish off this first level, try adding type signatures to both the function and the binding. Type signatures are never needed as the compiler can infer them, but we usually add them anyway to make our code easier to read.

Type signatures look like this:

```
addOne : Int -> Int
addOne x =
	x + 1
```

## Level 2 - Learning types

From here on we'll move in small steps, writing small chunks of code that will be a part of our final game, while adding more and more features from functional programming and Elm along the way. Ready, set, go!

### It's a new record!

We are going to create a representation of a "card" - something that is hiding a picture and can be flipped by the player. We'll start off with creating the equivalent data structure of a JavaScript object - a _record_ .

```
// JavaScript

var card = {
	name: 'Tom Cruise',
	expensiveShoes: true
}

-- Elm
card : { name: String, fancyShoes: Bool }
card = {
	name = "Tom Cruise",
	expensiveShoes = true
}
```

Our Elm record should contain a single field `id` of type String - this string will refer to the file name of the image our card will be hiding.

Next up - let's render our card to the screen. Write the following function:

`viewCard: { id: String ] -> Html a`

### About the scary type..

Don't worry about that scary type `Html a` - we'll learn more about that later! Simply put, it's just saying that "hey, our Html will emit som actions later on, and they'll be of type _a_ (which is a type placeholder)


### Rendering HTML to the screen

Oh, right, we didn't tell you about HTML yet! If you're familiar with the library React.js, the following section might feel familiar to you.

```
// JavaScript with React
<div class="ninja">
	<span>Banzai!</span>
</div>


-- Elm
div [ class "ninja" ] [
	span [] [ text "Banzai!" ]
]
```

All HTML tags have their own functions in Elm, and they all accept two parameters:

1. a list of `Html.Attribute`
2. a list of zero or more `Html` nodes

Here, we want you to represent a card with the following Html:

```
<div>
	<img src="/static/cats/" + card.id + ".jpg" />
</div>
```

Remember, the string concatenation operator is `++`!

You should now see a beautiful little kitten on you screen.

### Union Types: Representing card state

Memory requires us to flip a card and reveal it's image when clicked. This means we need a way to represent card state, as a card can be in one of three potential states: `{ open | closed | matched }`.

Think about how we'd store this state in JS. Most likely, we'd reach for a string:

```
{
	id: '1',
	state: 'open'
}
```

This is obviously not very safe. This doesn't constrain us to using only the three possible values, and there's nothing to avoid typing errors. Elm and other ML-languages have a great feature for this use case: _Union Types_.

A union type is like a Java or C# enumerable - a union type is a value that may be one of a fixed set of values. Like black pieces may only be white or black.

```
type PieceColor = White | Black
```

`PieceColor` is now treated a fullworthy type in our system, just as `String` or `Bool`. `White` or `Black` are _constructor functions_, functions that take _zero_ arguments and return a value of type `PieceColor`. Or, said with a type signature:

```
White : PieceColor
Black : PieceColor
```

Union types may also carry data. This means that the _constructor functions_ for such union type values aren't zero argument functions:

```
type CustomerAge = Unknown | Age Int

Unknown: CustomerAge
Age: Int -> CustomerAge
```

Let's say we either have an age value for a given customer, or we don't.
This _accompanying data_ that is wrapped within a union type may be of any type, and they don't have to the same for all value types within a union.

Some people say that _union types_ can be seen as _enums on stereoids_. In a way, thats fitting description.

Let's create a union type called `CardState` that can be either `open`, `closed` or `matched`.

Enrich our previous `card` record with a field `state` that carries a `CardState` value.
You'll also have to update the signature of `viewCard`.
Our `card` should now have the following type signature:

```
card: { id: String, state: CardState }
```

By now it should become clear that our signature for `card` is getting unwieldy. Imagine maintaining signatures for our card objects all around the codebase as we add more fields!

### Type Alias (alias slayer)

_Type aliases_ allow us to define a record with a specified data structure as a new type. Let's model everyone favourite data structure using a type alias:

```
type alias Person = {
	name: String,
	age: CustomerAge
}
```

The above code tells the Elm compiler that a `Person` is a record with a field `name` of type `String`, and a field `age` of the type `CustomerAge` (that we defined earlier).

This allows to use this type throughout our code:

```
getName : Person -> String
getName person =
	person.name
```

Imagine calling this function with an object without a name field. In JavaScript, this would obviously crash hard, but in Elm - the code won't even compile! This moves the time of discovering the error from compiletime og runtime, which is a huge deal.

Create a type alias `Card` that defines the card data structure from before. Use this new type in the signatures of `viewCard` and `card`



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

First, let's create some nice helper functions:
* `closeUnmatched : Deck -> Deck`
* `allMatched : Deck -> Bool` - Hint: the `List` module has a nice function called `all`
* `isMatching : Card -> Card -> Bool`. Hint: for two cards to match, both their `id`s and `group`s must match.

As we will soon see, our `setCard` will be more useful if it has this signature: `setCard : CardState -> Card -> Deck -> Deck`. That is, it should map over the passed deck and update the card in the list that matches the passed card with the passed `CardState`.


As we established earlier, our game has three states: `Choosing`, `Matching` and `GameOver`.
Let's implement this as a union type called `GameState`.

The `GameOver` state does not need any extra data, but `Choosing` needs a `Deck` (the deck we are choosing from), and `Matching` needs both a `Deck` (the deck we are choosing from) and a `Card` (the card we are trying to match with).

Instead of our `Model` holding a deck of cards, it should now hold a property (maybe called `state`?) with type `GameState`.
Hint: The `init` value should be `Choosing` with the static deck from `DeckGenerator`.

Since we now have to pattern match on both the `msg` and the game state in our update function, we can simplify things by creating a function that only takes care of updating the game state when the player clicks a card.
This function should have the following signature: `updateCardClick : Card -> GameState -> GameState`.
* In `Choosing` state
  1. Close all unmatched cards
  2. Open the clicked card
* In `Matching` state
  1. When the two cards match , set both cards to `Matched`. When the two cards do not match, set the clicked card to `Open`.
  1. If all cards are now matched, go to `GameOver`. If not, go to `Choosing`.
* In `GameOver` state, do nothing


You will also have to update the `view` function to accomodate for the new shape of our model.
Refreshing the page every time you want to play another game is boring, so try to add a "restart game" button in the "Game over" view. Hint: it is common to have a top-level value called `init`.

Now, take a minute to pat yourself on the back for making an awesome game in Elm!


## Level 6 - Side effects and randomness
1. Change `beginnerProgram` to `program`
  * Rename `model` to `init`
  * Add `subscriptions = \_ -> Sub.none`
  * Change `init` and `update` according to new type sigs (`Cmd.none`)
1. Add new constructor for `Msg`; `DeckGenerated Deck`
1. When starting the game, return the command `Random.generate DeckGenerated DeckGenerator.random`


## Bonus levels
* Count the number of attempts the player uses, use that as score
* Let the player enter a name
* Save each game's score and show a high score table
* Count how long the player takes to finish the game. Use [Time.now](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Time#now) together with [Task.perform](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Task#perform) to get the current time
