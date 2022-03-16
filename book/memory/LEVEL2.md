## Level 2 - Learning types

> The goal of this level is to learn about custom types and type aliases, which we often use to represent state.

From here on we'll move in small steps, writing small chunks of code that will be a part of our final game, while using more and more features from functional programming and Elm along the way. Ready, set, go!

### 2.1 It's a new record!

We are going to create a representation of a "card" - something that is hiding a picture and can be flipped by the player. We'll start off by creating the equivalent data structure of a JavaScript object - a _record_. You can see the similarities between JavaScript objects and Elm records here:

```javascript
// JavaScript object
var person = {
    name: "Tom Cruise",
    expensiveShoes: true,
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

---

**Task**: Create an Elm record with the type `{ id : String }` called `myCard`. Use `id = "1"` for the initial value. This `id` string will refer to the file name of the image our card will be hiding.

### 2.2 Rendering HTML to the screen

All HTML tags have corresponding functions in Elm, and they all accept two parameters:

1. a list of zero or more `Html.Attribute`
1. a list of zero or more `Html` nodes

```html
<!-- HTML -->
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

For example, the function to create a `div` node has this signature: `div : List (Attribute msg) -> List (Html a) -> Html a`

> #### Note about `Html a`
>
> Don't worry about that scary type `Html a` - we'll learn more about that later! Simply put, it's just saying that "hey, our HTML will emit some actions later on, and they will be of type `a` (which is a type variable, or a wildcard).

---

**Task**: Write the function `viewCard: { id: String } -> Html a`, which should output the following HTML:

```html
<div>
    <img src="/cats/{card.id}.png" />
</div>
```

##### Hint

These functions will be useful (they are included in the standard library so you don't have to write them yourself):

-   `div : List (Attribute msg) -> List (Html a) -> Html a`
-   `img : List (Attribute msg) -> List (Html a) -> Html a`
-   `src : String -> Attribute msg`

To get the `src` function you should put `import Html.Attributes exposing (..)` near the beginning of your file.

Remember also that string concatenation is done with `++`.

If you now substitute the `greet` call in `main` with `viewCard` called with the record you created earlier you should see a beautiful little kitten on you screen!

### 2.3 Custom Types: Representing card state

Memory requires us to flip a card and reveal its image when clicked. This means we need a way to represent card state, as a card can be in one of three potential states: `Open | Closed | Matched`.

Think about how we'd store this state in JS. Most likely, we'd reach for a string:

```javascript
{
	id: '1',
	state: 'open' // or 'closed' or 'matched'
}
```

This is obviously not very safe. This doesn't constrain us to using only the three possible values, and there's nothing to avoid typing errors. Elm and other ML-languages have a great feature for this use case: _Custom Types_.

A custom type is somewhat like a Java enumerable or C# enum - a custom type is a value that may be one of a fixed set of values. Chess pieces, for example, can only be either white or black.

```elm
type PieceColor = White | Black
```

`PieceColor` is now a normal type in our system, just as `String` or `Bool`. `White` or `Black` are _constructor functions_. In this case they take _zero_ arguments and return a value of type `PieceColor`. Or, expressed with a type signature:

```elm
White : PieceColor
Black : PieceColor
```

Custom types may also carry data. This means that the _constructor functions_ for such custom type values aren't zero argument functions. Let's look at an example:

```elm
type CustomerAge = Unknown | Known Int
-- Unknown : CustomerAge
-- Known : Int -> CustomerAge
```

This can be used to represent a customer's age in a situation where we might not know the age.
We see that the constructor function `Known` takes an `Int` argument and returns a `CustomerAge`.

We can wrap _any_ type of _accompanying data_ within a custom type value (like `Known`), and the type of the accompanying data doesn't have to be the same for all the value types within a union.

This is incredibly useful, and we will now make our own!

---

**Task**:

1. Create a custom type called `CardState` that can be either `Open`, `Closed` or `Matched` (_constructor functions_ are always capitalized).
1. Enrich our previous `Card` record with a field called `state` that carries a `CardState` value.
   You will also have to update the signature of `viewCard`.

-   Our `myCard` value should now have the following type signature:

```elm
myCard : { id : String, state : CardState }
```

### 2.5 Type Alias (alias slayer)

By now we see that our signature for `card` is getting unwieldy. Imagine maintaining the signatures for our card objects all around the codebase as we add more fields. It doesn't exactly scale.

Enter _type aliases_!

_Type aliases_ allow us to...

-   ...give a name to records with a specified structure, and use it as a type.
-   ...define a record with a specified data structure as a new type.

Let's look at an example.

```elm
customer : { name : String, age: CustomerAge }
customer =
    { name = "Evan"
    , age = Unknown
    }

getName : { name : String, age: CustomerAge } -> String
getName customer =
	customer.name
```

If we create a type alias, we can use this in the type signatures:

```elm
type alias Customer =
    { name: String
    , age: CustomerAge
    }

customer : Customer
customer = ...

getName : Customer -> String
getName customer = ...
```

The type alias tells the Elm compiler that a `Customer` is a record with a field `name` of type `String`, and a field `age` of the type `CustomerAge` (that we defined earlier).

Imagine calling the `getName` function with an object without a name field.
In JavaScript, this would obviously crash hard, but in Elm - the code won't even compile!
This moves the discovery of errors from runtime to compile time (when you hit _save_ in your editor), which significantly improves our feedback cycle!

---

**Task**: Create a type alias called `Card` that describes our card record. Use this new type in the signatures of `viewCard` and `myCard`.

### 2.6 Render all the states!

Our cards can be either `Open`, `Closed` or `Matched`, and we want to display each state differently.
For this we will be using a language feature called _pattern matching_.
It can best be described as a switch-statement on steroids, allowing us to do more than simple matching on a value.

Example:

```elm
isAdult : CustomerAge -> Bool
isAdult customerAge =
    case customerAge of
        Known age ->
            age > 18

        Unknown ->
            False
```

Notice that we can even extract the value that was used when `Known : Int -> CustomerAge` was used!
This is a powerful technique, and is almost always used whenever there's a custom type around.

In our case, it is handy for rendering different stuff based on the `CardState` of a card.

In `viewCard`, use the following logic (css classes should be applied to the `img` tag):

-   When `Closed` -> show `/cats/closed.png` and the css class `closed`
-   When `Open` -> show `/cats/{cardId}.png` and the css class `open`
-   When `Matched` -> show `/cats/{cardId}.png` and the css class `matched`

Having only one card is pretty boring and we won't to be able to see all the different states, so let's create a list of them.
Lists in Elm is created with `[]`, just like in JavaScript.
Put three cards in the list; one with `id = 1`, one with `id = 2` and one with `id = 3`. Each should also have a different value for `state`.

---

**Task**:

1. Update `viewCard` to display differently based on the card's `state`
1. Create `myCards : List Card`
1. Create `viewCards : List Card -> Html a` - the cards should be placed in a `div` with the css class `cards`
1. Call `viewCards` from `main`

##### Hint:

Use the built-in function `List.map : (a -> b) -> List a -> List b` to convert a list of `Card` to a list of `Html a`.
Remember that `div : List (Attribute msg) -> List (Html a) -> Html a` – notice the second argument (`List (Html a)`)and how it corresponds with the return value of `List.map`.

Notice how the type signature helps in communicating what the function does!
Type signatures are a very powerful tool, as you will discover throughout this workshop.

Make sure you render the correct image source for each card (`{card.id}.png`).
