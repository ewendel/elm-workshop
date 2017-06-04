## Level 2 - Learning types
> The goal of this level is to learn union types and type aliases, which we often use to represent state.

From here on we'll move in small steps, writing small chunks of code that will be a part of our final game, while using more and more features from functional programming and Elm along the way. Ready, set, go!

### 2.1 It's a new record!

We are going to create a representation of a "card" - something that is hiding a picture and can be flipped by the player. We'll start off with creating the equivalent data structure of a JavaScript object - a _record_. You can see the similarities between JavaScript objects and Elm records in the two code examples at the bottom of this section.

Our Elm record should have the type `{ id : String }`. The `id` string will refer to the file name of the image our card will be hiding. Start with `id = "1"`.

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



### 2.2 Rendering HTML to the screen

Here, we want you to represent a card with the following HTML:

```html
<div>
	<img src="/static/cats/{card.id}.jpg" />
</div>
```
Oh, right, we didn't tell you about HTML yet! If you're familiar with the library `React.js`, the following section might feel familiar to you.

```html
// HTML
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

Example: `div : List (Attribute msg) -> List (Html a) -> Html a`

##### Hint
Write the following function: `viewCard: { id: String } -> Html a` by using these:
* `div : List (Attribute msg) -> List (Html a) -> Html a`
* `img : List (Attribute msg) -> List (Html a) -> Html a`
* `src : String -> Attribute msg`

To get the `src` function you should put `import Html.Attributes exposing (..)` near the beginning of your file.

Remember that string concatenation is done with `++`.

If you call `viewCard` with the card record you created in the previous task you should now see a beautiful little kitten on you screen!

>#### Note about `Html a`
>Don't worry about that scary type `Html a` - we'll learn more about that later! Simply put, it's just saying that "hey, our HTML will emit some actions later on, and they will be of type `a` (which is a type variable, or a wildcard).

### 2.3 Union Types: Representing card state

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


1. Let's create a union type called `CardState` that can be either `Open`, `Closed` or `Matched` (_constructor functions_ are always capitalized).

1. Enrich our previous `card` record with a field called `state` that carries a `CardState` value.
You will also have to update the signature of `viewCard`.

1. Our `card` value should now have the following type signature:
```
card: { id: String, state: CardState }
```

By now it should become clear that our signature for `card` is getting unwieldy. Imagine maintaining signatures for our card objects all around the codebase as we add more fields!

### 2.5 Type Alias (alias slayer)

_Type aliases_ allow us to...
* ...give a name to records with a specified structure, and use it as a type.
* ...define a record with a specified data structure as a new type.

Create a type alias, as described below, called `Card` that defines the card data structure from before.
Use this new type in the signatures of `viewCard` and `card`.

##### Hint
Let's model everyone's favourite data structure using a type alias:

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



### 2.6 Render all the states!

Having only one card is boring, so create a list of three cards, each having different values for `state` (and maybe `id` too?).

Next, we're going to create this function: `viewCards : List Card -> Html a`.

Notice how the type signature helps in communicating what the function does!
Type signatures are a very powerful tool, as you will discover throughout this workshop.

Make sure you render the correct image source for each card (`{card.id}.jpg`).

##### Hint:
* `viewCard : Card -> Html a`
* `cards : List Card`
* `List.map : (a -> b) -> List a -> List b`
* `div : List (Atribute msg) -> List (Html a) -> Html a`

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

