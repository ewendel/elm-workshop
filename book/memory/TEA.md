## Level 2.5 - TEA TIME

The Elm architecture is made up of three parts: `model`, `view` and `update`.

##### Model
The model is the state of our application.
The application state can consist of for example data fetched from an API, which page the user is currently viewing, the current state of an input form etc.
In Elm this is usually modeled with a record, defined by using a `type alias`.
For example:
```elm
type alias Model =
    { userList : List User
    , currentPage : Page
    , nameInput : String
    }
```

##### View
A function that takes the current application state as an argument and returns some HTML.

##### Update
A function that takes a "message", the current application state and returns an updated application state.
This message is modeled with a union type, so usually the `update` function consists of pattern matching on the message value.

Messages are events that happen in our application.
These could be for example:
* User clicked the cancel button
* User clicked the exit button
* User entered some text in a text field
* We received some data from an API


### `Html.beginnerProgram`
`Html.beginnerProgram` is the simplest way to run an Elm application.
It takes only one argument; a record with a field for the initial application state (`model`), a field for the `update` function, and a field for the `view` function.
With this, the Elm runtime will make sure that when there's some user-input in your application, the message will be sent to your `update` function, and when you have updated your model it will be sent to the `view` function so the HTML gets updated.

Let's examine `beginnerProgram`'s type signature.

```elm
beginnerProgram
    : { model : modelType
      , view : modelType -> Html msgType
      , update : msgType -> modelType -> modelType }
    -> Program Never
```

Here we can see that because of Elm's static typing these three fields must "match" each other:
* The type of the initial model must match the type of the argument to the `view` function.
* The type of messages returned from `view` (the `msgType` part in `Html msgType`) must be the same type as the first argument to `update`
* The type of the second argument to `update` must match the type of the model

`beginnerProgram` returns a `Program Never` but you can forget about the `Never` part for now.
The important part is that it returns a `Program`, which is just what the Elm runtime wants.

> #### `Html msgType`
> This part can seem a bit confusing, so let's look at lists first.
> A list in Elm has the type `List someType`.
> This means that it is a list where the elements are of type `someType`.
> For example:
> * `List Int` is a list of ints
> * `List String` is a list of strings
>
> The concept is the same for `Html msgType`. It says that the HTML "contains" some `msgType`; all messages that come from this bit of HTML will be of type `msgType`.
> For example:
> * `Html Int` - messages from this HTML will be ints
> * `Html String` - messages from this HTML will be string
>
> In practice we will use `union types` for our messages as they are incredibly useful, but it is useful to realize that our messages could in principle be of _any_ type.
>
> In the end, this means that when you hook up your `view` and `update` functions using `Html.beginnerProgram`, the messages sent to `update` will be of the type contained in the HTML.

---

### Exercise time

To practice using the Elm architecture we will create the "Hello, world" of interactive web applications; a counter app.
It will consist of one button for incrementing a number, one button for decrementing a number and a `<span>` for showing the number.


You can use the following skeleton code to get quickly up and running:

```elm
module Main exposing (..)

import Html exposing (..)

main =
    Html.beginnerProgram
        { model = 0
        , update = update
        , view = view
        }

type alias Model
    = Int

type Msg
    = NoOp

update : Msg -> Model -> Model
update msg model =
    model

view : Model -> Html Msg
view model =
    text "Hello, I'm a view"
```


---
**Task**:
1. Implement the view function. It should output the following HTML (substitute `0` for the value of the model):
```html
<div>
    <button>-</button>
    <span>0</span>
    <button>+</button>
</div>
```
1. Create messages for incrementing and decrementing the model
    * These should be `constructor function`s for the `Msg` type
    * When you have done this, use pattern matching on the value of `msg` (`case msg of ...`) in `update`.
1. Add onClick handlers on the two buttons
    * `onClick` is a function from the `Html.Events` module.
    Import it by adding `import Html.Events exposing (onClick)` at the top of your file
    * It has the type `onClick : msgType -> Attribute msgType`.
    Remember also that the second argument of HTML nodes (`button` in our case here) is of type `List (Attribute msgType)`

When you have done this, you should be able to increment and decrement the number by clicking on the buttons!

---

**Bonus level**:

Can you modify the program so that you have buttons for incrementing/decrementing by 1, 5 and 10 without using more than two different messages?

---

> Hint: `constructor function`s can take arguments
