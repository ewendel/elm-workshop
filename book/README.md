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
* Maybe
* Html.beginnerProgram
* Piping

Some of these concepts may be unfamiliar and somewhat confusing to begin with, so please do ask us if and when you get stuck, or simply have a question. That's what we're here for!

## Presentation slides

The slides from the presentation are available here: [part 1](https://drive.google.com/open?id=0B3Lh4pXvCuflWTFtT3JfMFh0VG8) & [part 2](https://drive.google.com/open?id=0B3Lh4pXvCuflbENPVmZmSTlCOHM).

## Code

The code for the workshop is available here: https://github.com/ewendel/elm-workshop.

## Prerequisites

1. Install `node` version 7 or newer (which includes `npm`) from [nodejs.org](https://nodejs.org/en/download/current/).

1. Install `elm`. This can be done with `npm install -g elm`, `brew install elm` (if on MacOS) or an old-school file download from [elm-lang.org](https://guide.elm-lang.org/install.html).

1. Install a [`plugin`](https://guide.elm-lang.org/install.html#configure-your-editor) for your editor. At the time of writing, Atom's Elm integration seems the best so we **strongly** recommend you use that, even if Atom is not usually your main editor of choice.
    * The following packages are needed for a pleasant development experience in Atom:
        * `language-elm`
        * `linter-elm-make`
        * `elmjutsu`
        * `elm-format`

1. Install [`elm-format`](https://github.com/avh4/elm-format#for-elm-018), which is a crucial tool to make your Elm experience more enjoyable.
    * `npm install -g elm-format`
    * Remember to make sure that `elm-format` is available on your PATH or that you tell your editor where to find it
    * In Atom, this can be done under package settings for the `elm-format` package: input the path to the `elm-format` binary.
    * You can find the path for `elm-format` by doing `which elm-format` on MacOS/*Nix or `Get-Command elm-format` in powershell on Windows
    * We also recommend you enable `Format on save` in your editor

1. Clone the repo (https://github.com/ewendel/elm-workshop) to your computer

1. Run `npm install` (please make sure to have `npm` version 3 or newer)

1. Start your local application environment with `npm start` in the root folder of this repo. This should open a new browser window with `localhost:3000` and a nice compilation error.

Congratulations, you're now ready to begin learning Elm!

---


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
