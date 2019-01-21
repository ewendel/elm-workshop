## Level 1 - Model

When working in a language with a good type system, it is often a good idea to start development by modeling the types that will be used in your program.

We encourage you to take a stab at this yourself first, but we have included one way of doing it below.

Try designing the model before you think about the implementation at all.
If your model becomes hard to work with it is always okay to go back and refactor.

By the end of this section you should be have created an initial `Model` for the minesweeper game.

---

#### Example domain model for Minesweeper:

```elm
type alias Model =
    { state : GameState
    , board : Board
    }


type alias Board =
    List Cell


type alias Cell =
    { cellState : CellState
    , cellType : CellType
    }


type GameState
    = NotStarted
    | Playing
    | Lost
    | Won


type CellState
    = Open
    | Closed
    | Flagged


type CellType
    = Mine
    | Safe Int -- The `Int` here represents how many of the neighboring cells that are mines
```

Note that we use a one-dimensional list to represent the board state.
This makes it easier to do some operations, for example creating random boards (hint: [Random.List.shuffle](https://package.elm-lang.org/packages/elm-community/random-extra/latest/Random-List#shuffle)).
There are other situations where you might find this representation cumbersome to work with, for example when determining neighbors of a cell.
In these cases you might want to consider transforming the list into more suitable representations and working with these locally.
