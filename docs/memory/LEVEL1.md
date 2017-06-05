# Level 1 - Hello, world!
The goal of this level is to print "Hello, (name)" to the screen.

## 1.1 Displaying text

Locate the file _Main.elm_, which should look like this:

```elm
module Main exposing (..)

import Html exposing (..)

main =
    "Hello, world!"
```

As you can see in your browser, the app will fill the screen with an error message that your code does not compile.
This might be unfamiliar to you if you're coming from JavaScript to Elm. With JavaScript you have to run your code in the browser to discover any programming mistakes you might have made, while with Elm these errors will be caught right as you hit save in your editor!

> #### A note on Elm's compiler:
>
> Elm is famous for it's compiler errors.
>If you get stuck with your program not compiling, please read the error message carefully.
>The creators of Elm have put a lot of energy into making these error messages helpful, and they are!
>Most times they tell you exactly what you have to do to make your program work.

Now, study the on-screen error message.

Our app is now telling us that the value of `main` has the wrong type: it is a `String` but it should be either `Html`, `Svg` or `Program`.

Luckily, we have function named `text` for turning a `String` (such as `"Hello, world!"`) into `Html`. The function has the following signature `text : String -> Html a`, and you can read it's documentation [here](http://package.elm-lang.org/packages/evancz/elm-html/4.0.1/Html#text).

>#### Note:
>* The official docs has a nice chapter on ["Reading types in Elm"](https://guide.elm-lang.org/types/reading_types.html)
>* Elm-tutorial has a nice chapter on functions in Elm: ["Function basics"](https://www.elm-tutorial.org/en/01-foundations/02-functions.html)

---

**Task**: Use the function `text` to make your program compile and print "Hello, world!" to the screen.

## 1.2 Creating a greeting function

Now we want to create a function that takes a name as input and returns a greeting.
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


---

**Task**: Go ahead and make the `greet` function. The string concatenation operator in Elm is `++`.

## 1.3 Adding type signatures

Before we finish off the first level, try adding the type signature for your `greet` function.
As mentioned, type signatures are not needed, as the compiler can infer them, but it is good practice to add them anyways.
This makes the code easier to read and can help you get better error messages.

---
**Task**: Add the type signature for the `greet` function

