# Elm Arcade 
# Getting Started With Elm and Typed Functional Programming

Welcome to this workshop! Today we're learning Elm and typed functional programming techniques through creating the classic game Memory.

The workshop will cover the following topics:

* Tuples
* Records
* Type Inference
* Type Signatures
* Union Types
* Type Aliases
* Pattern Matching
* Functions
* Partial Application
* Currying

Some of these concepts may be unfamiliar and somewhat confusing to begin with, so please do ask us if and when you get stuck, or simply have a question. That's what we're here for!

## Presentation slides

The slides from the presentation are available [here](https://drive.google.com/file/d/0B3Lh4pXvCuflcnpKWHhBUzU2c0U/view?usp=sharing).

## Prerequisites

1. Install `elm`. This can be done with `npm install -g elm`, `brew install elm` (if on MacOS) or an old-school file download from [elm-lang.org](https://guide.elm-lang.org/install.html).

1. Install a [`plugin`](https://guide.elm-lang.org/install.html#configure-your-editor) for your editor. At the time of writing, Atom's Elm integration seems the best so we **strongly** recommend you use that, even if Atom is not usually your main editor of choice.

    *  [Atom editor setup](https://github.com/halohalospecial/atom-elmjutsu#setup)


1. [`elm-format`](https://github.com/avh4/elm-format#for-elm-018) is a crucial tool to make your Elm experience more enjoyable.
    * Remember to make sure that `elm-format` is available on your PATH or that you tell your editor where to find it
    * In Atom, this can be done under package settings for the `elm-format` package: input the path to the `elm-format` binary. (If you for example installed it via `brew` on MacOS, the path should be along the lines of `/urs/local/bin/elm-format-0.18`)
    * We also recommend you enable `Format on save`

1. Clone this repo to your computer

1. Run `npm install`

1. Start your local application enviroment with `npm start` in the root folder of this repo. This should open a new browser window with `localhost:3000` and a nice compilation error.

Congratulations, you're now ready to begin learning Elm!

## Level 1 - Hello, world!
File: _Main.elm_

Main.elm should look like this:

```elm
module Main exposing (..)

import Html exposing (..)

main =
    "Hello, world!"
```

As you can see in your browser, the app will fill the screen with an error message then your code does not compile.
This might be unfamiliar to you if you're coming from JavaScript to Elm. With JavaScript you have to run your code in the browser to discover any programming mistakes you might have made, while with Elm these errors will be caught right as you hit save in your editor!

> #### A note on Elm's compiler:
>
> Elm is famous for it's compiler errors.
>If you get stuck with your program not compiling, please read the error message carefully.
>The creators of Elm have put a lot of energy into making these error messages helpful, and they are!
>Most times they tell you exactly what you have to do to make your program work.

Now, study the on-screen error message.

Our app is now telling us that the value of `main` has the wrong type: it is a `String` but it should be either `Html`, `Svg` or `Program`.

Luckily, we have function named `text` for turning a `String` (such as `"Hello, world!"`) into `Html`. The function has the following signature `text : String -> Html msg`, and you can read it's documentation [here](http://package.elm-lang.org/packages/evancz/elm-html/4.0.1/Html#text).

>#### Note:
>* The official docs has a nice chapter on ["Reading types in Elm"](https://guide.elm-lang.org/types/reading_types.html)
>* Elm-tutorial has a nice chapter on functions in Elm: ["Function basics"](https://www.elm-tutorial.org/en/01-foundations/02-functions.html)

Use the function `text` to make your program compile and print "Hello, world!" to the screen.

### Creating a greeting function

Now we want to create a function that takes a name and greets.
It should have this type signature: `greet: String -> String`.

Called with the argument "Erik", the function should produce the string "Hello, Erik". Thus:

```
> greet "Erik"
"Hello, Erik" : String
```

Here is an example of a function that takes two numbers and returns the sum of those numbers:

```
add x y =
	x + y
```

There are several things to note here:

* There's no `return` keyword - the evaluated value of the function body is automatically returned
* The parameters are named and come after the function name
* You don't have to specify the types for the parameters - they are _inferred_! This can be done because Elm sees the addition operator (`+`) and knows that it only works on numbers. Therefore, `x` and `y` must be numbers!

Go ahead and make the `greet` function. The string concatenation operator in Elm is `++`.

### Adding type signatures

Before we finish off the first level, try adding the type signature for your `greet` function.
As mentioned, type signatures are not needed, as the compiler can infer them, but it is good practice to add them anyways.
This makes the code easier to read and can help you get better error messages.


## Level 2 - Learning types

From here on we'll move in small steps, writing small chunks of code that will be a part of our final game, while using more and more features from functional programming and Elm along the way. Ready, set, go!

### It's a new record!

We are going to create a representation of a "card" - something that is hiding a picture and can be flipped by the player. We'll start off with creating the equivalent data structure of a JavaScript object - a _record_ .

Example comparison:
```javascript
// JavaScript object
var person = {
	name: 'Tom Cruise',
	expensiveShoes: true
};
```
```elm
-- Elm record
person : { name: String, fancyShoes: Bool }
person =
    { name = "Tom Cruise"
    , fancyShoes = True
    }
```

Our Elm record should have the type `{ id : String }`. The `id` string will refer to the file name of the image our card will be hiding. Start with `id = "1"`.

### Rendering HTML to the screen

Oh, right, we didn't tell you about HTML yet! If you're familiar with the library `React.js`, the following section might feel familiar to you.

```javascript
// JavaScript with React
<div class="ninja">
	<span>Banzai!</span>
</div>
```


```elm
-- Elm
div [ class "ninja" ]
    [ span [] [ text "Banzai!" ] 
    ]
```

All HTML tags have corresponding functions in Elm, and they all accept two parameters:

1. a list of `Html.Attribute`
1. a list of zero or more `Html` nodes

Example: `div : List (Attribute msg) -> List (Html msg) -> Html msg`

Here, we want you to represent a card with the following Html:

```
<div class "cards">
	<img class "card" src="/static/cats/{card.id}.jpg" />
</div>
```

Write the following function: `viewCard: { id: String } -> Html msg` by using these:
* `div : List (Attribute msg) -> List (Html msg) -> Html msg`
* `img : List (Attribute msg) -> List (Html msg) -> Html msg`
* `src : String -> Attribute msg`

To get the `src` function you should put `import Html.Attributes exposing (..)` near the beginning of your file.

Remember that string concatenation is done with `++`.

If you call `viewCard` with the card record you created in the previous task you should now see a beautiful little kitten on you screen!

>#### Note about `Html msg`
>Don't worry about that scary type `Html msg` - we'll learn more about that later! Simply put, it's just saying that "hey, our HTML will emit some actions later on, and they will be of type `msg` (which is a type placeholder).

### Union Types: Representing card state

Memory requires us to flip a card and reveal it's image when clicked. This means we need a way to represent card state, as a card can be in one of three potential states: `Open | Closed | Matched`.

Think about how we'd store this state in JS. Most likely, we'd reach for a string:

```javascript
{
	id: '1',
	state: 'open' // or 'closed' or 'matched'
}
```

This is obviously not very safe. This doesn't constrain us to using only the three possible values, and there's nothing to avoid typing errors. Elm and other ML-languages have a great feature for this use case: _Union Types_.

A union type is like a Java or C# enumerable - a union type is a value that may be one of a fixed set of values. Chess pieces, for example, can only be either white or black.

```elm
type PieceColor = White | Black
```

`PieceColor` is now treated as a normal type in our system, just as `String` or `Bool`. `White` or `Black` are _constructor functions_, functions that take _zero_ arguments and return a value of type `PieceColor`. Or, expressed with a type signature:

```elm
White : PieceColor
Black : PieceColor
```

Union types may also carry data. This means that the _constructor functions_ for such union type values aren't zero argument functions. Let's look at an example:

```elm
type CustomerAge = Unknown | Known Int
-- Unknown : CustomerAge
-- Known : Int -> CustomerAge
```
This can be used to represent a customer's age in a situation where we might not know the age.
We see that the constructor function `Known` takes an `Int` argument and returns a `CustomerAge`.

We can wrap any type of _accompanying data_ within a union type value (like `Known`), and the type of the accompanying data doesn't have to be the same for all the value types within a union.

This is incredibly useful, and we will now make our own!


Let's create a union type called `CardState` that can be either `Open`, `Closed` or `Matched` (_constructor functions_ are always capitalized).

Enrich our previous `card` record with a field called `state` that carries a `CardState` value.
You will also have to update the signature of `viewCard`.

Our `card` value should now have the following type signature:

```
card: { id: String, state: CardState }
```

By now it should become clear that our signature for `card` is getting unwieldy. Imagine maintaining signatures for our card objects all around the codebase as we add more fields!

### Type Alias (alias slayer) 

_Type aliases_ allow us give a name to records with a specified structure, and use it as a type.

_Type aliases_ allow us to define a record with a specified data structure as a new type. Let's model everyone's favourite data structure using a type alias:

```elm
type alias Customer =
    { name: String
    , age: CustomerAge
    }
```

The above code tells the Elm compiler that a `Customer` is a record with a field `name` of type `String`, and a field `age` of the type `CustomerAge` (that we defined earlier).

This allows to use this type throughout our code:

```elm
getName : Customer -> String
getName customer =
	customer.name
```

Imagine calling this function with an object without a name field.
In JavaScript, this would obviously crash hard, but in Elm - the code won't even compile!
This moves the discovery of errors from runtime to compile time (when you hit _save_ in your editor), which significantly improves our feedback cycle!

Now, create a type alias called `Card` that defines the card data structure from before.
Use this new type in the signatures of `viewCard` and `card`

### Render all the states!

Having only one card is boring, so create a list of three cards, each having different values for `state` (and maybe `id` too?).

Next, we're going to create this function: `viewCards : List Card -> Html msg`.

Notice how the type signature helps in communicating what the function does!
Type signatures are a very powerful tool, as you will discover throughout this workshop.

Make sure you render the correct image source for each card (`{card.id}.jpg`).

> Hint:
> * `viewCard : Card -> Html msg`
> * `cards : List Card`
> * `List.map : (a -> b) -> List a -> List b`
> * `div : List (Atribute msg) -> List (Html msg) -> Html msg`

### Match all the patterns!

The next language feature we will be using is _pattern matching_. It can best be described as a switch-statement on stereoids, allowing us to do more than simple matching on a value:

```elm
isAdult : CustomerAge -> Bool
isAdult age =
    case age of
        Known age ->
            age > 18

        Unknown ->
            False
```

Notice that we can even extract the value that was used when `Known : Int -> CustomerAge` was used!

This is a powerful technique, and is almost always used whenever there's a union type around. In this case, it is handy for rendering different stuff based on the `CardState` of a card.

In `viewCard`, use the following logic (css classes should be applied to the `img` tag):
* When `Closed` -> show `/static/cats/closed.png` and the css class `closed`
* When `Open` -> show `/static/cats/{cardId}.jpg` and the css class `open`
* When `Matched` -> show `/static/cats/{cardId}.jpg` and the css class `matched`

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
1. Use pattern matching in `update` on the type of `Msg` and open the clicked card
1. Add `import Html.Events exposing (..)` and add an `onClick` event handler on closed cards.

When this section is complete, you should render three closed cards, each of them opening when clicked.

## Level 4 - The game!

We are now going to implement the game logic.

In memory, as you may know, the player opens two cards, one after another, and if they match they stay open.
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
    1. If it matches the first card, then set the two cards to `Matched`, else set the second card to `Open`
	1. If all cards are `Matched`, then go to `GameOver` state, else go to `Choosing` state
    

Let's get back to the code.

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

As we've established, our game has three states: `Choosing`, `Matching` and `GameOver`.
Implement this as a union type called `GameState`.

The `GameOver` state does not need any extra data, but `Choosing` needs a `Deck` (the deck we are choosing from), and `Matching` needs both a `Deck` (the deck we are choosing from) and a `Card` (the card we are trying to match with).

To recap our implementation with regards to the `update` function:
* In `Choosing` state
  1. Close all unmatched cards
  1. Open the clicked card
  1. Go to `Matching`
* In `Matching` state
  1. When the two cards match , set both cards to `Matched`. When the two cards do not match, set the clicked card to `Open`.
  1. If all cards are now matched, go to `GameOver`. If not, go to `Choosing`.
* In `GameOver` state, do nothing


You will also have to update the `view` function to accomodate for the new shape of our model.

Now take a minute and pat yourself on the back for making an awesome game in Elm!

>#### Optional:

>Refreshing the page every time you want to play another game is boring, so try to add a "restart game" button in the "Game over" view. Hint: it is common to have a top-level value called `init` that contains the initial state of the `model`.

## Level 5 - Let's get random!

You might have noticed that our game is kind of easy; the cards are in the same spots every time, and that's no fun!
We will now make things more interesting by shuffling the deck of cards at the start of each game.

Shuffling a list of something includes randomness, and generating random numbers is an impure operation.
Elm is a _pure_ functional language, and if you look through the type signatures of the functions we have written so far, there is no way to express impurity.
Luckily, there is a way to do exactly that.

> #### Why is generating random numbers impure?
> Take for example JavaScript's function `Math.random()`, which produces random floating point numbers. It takes zero arguments and it will (probably) give you a different number back each time you call it.

> From wikipedia:
> > random() is impure because each call potentially yields a different value. This is because pseudorandom generators use and update a global "seed" state. If we modify it to take the seed as an argument, i.e. random(seed); then random becomes pure, because multiple calls with the same seed value return the same random number.

To generate something random, we can to use the built-in function `Random.generate : (a -> msg) -> Generator a -> Cmd msg`.
The `Generator a` part is covered by `DeckGenerator.random : Generator Deck`, so that means you have to supply a function that takes a `Deck` and returns a `Msg`.

Now you're probably wondering what that `Cmd` thingy is, so take a minute and head on over to [elm-tutorial.org](https://www.elm-tutorial.org/en/), which has a nice explanation of [commands](https://www.elm-tutorial.org/en/03-subs-cmds/02-commands.html).

Since we're now not longer _beginners_ we should change our `Html.beginnerProgram` to `Html.program`.

There are a couple of changes we have to do to make this official transition from _beginners_ to _adepts_.

* The argument to `Html.program` differ slightly from the argument to `Html.beginnerProgram`:
  1. `model` is now called `init`, and it's type is now `(Model, Cmd Msg)`
  1. The record should have a new field called `subscriptions : Model -> Sub Msg`.
* `update` now has the type signature `update : Msg -> Model -> (Model, Cmd Msg)`

The official docs has a nice exaplanation of what [_subscriptions_](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Platform-Sub#Sub) are.

Hint: in your code you can use `Sub.none` and `Cmd.none` when you don't have any _subscriptions_ or _commands_ you want to perform.

So, to summarize:

* Use `Random.generate : (a -> msg) -> Generator a -> Cmd msg` and `DeckGenerator.random : Generator Deck` to get a different deck each time the game is started.

## Game over?

And there you have it! You have now created your own version of a memory game with Elm (and cats)!

Hopefully this is just the beginning of your journey with Elm. Please do reach out to us (links at the bottom) if you have any feedback on the workshop or if you just want to get in touch.


## Bonus levels
* Count the number of attempts the player uses, use that as score
* Let the player enter a name
* Save each game's score and show a high score table
* Count how long the player takes to finish the game. Use [Time.now](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Time#now) together with [Task.perform](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Task#perform) to get the current time


<h2 align="center">Made by</h2>

<table>
  <tbody>
    <tr>
      <td align="center" valign="top">
        <img width="150" height="150" src="https://github.com/ingara.png?s=150">
        <br>
        <a href="https://github.com/ingara">Ingar Almklov</a>
        <br />
        <br />
        <p><small><a href="https://twitter.com/ingara">@ingara</a></small></p>
      </td>
      <td align="center" valign="top">
        <img width="150" height="150" src="https://github.com/ewendel.png?s=150">
        <br>
        <a href="https://github.com/ewendel">Erik Wendel</a>
        <br />
        <br />
        <p><small><a href="https://twitter.com/ewndl">@ewndl</a></small></p>
      </td>
     </tr>
  </tbody>
</table>
