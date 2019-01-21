## Level 2 - Hard-coding for the greater good

By the end of this level you should have implemented the view function for the game.

You can use this hard-coded board for testing your view function:

```elm
board : Board
board =
    -- Rad 1
    [ Cell Open (Safe 0)
    , Cell Open (Safe 0)
    , Cell Open (Safe 1)
    , Cell Flagged (Safe 2)
    , Cell Closed (Safe 2)

    -- Rad 2
    , Cell Open (Safe 0)
    , Cell Open (Safe 0)
    , Cell Open (Safe 1)
    , Cell Open Mine
    , Cell Open Mine

    -- Rad 3
    , Cell Open (Safe 0)
    , Cell Open (Safe 0)
    , Cell Open (Safe 1)
    , Cell Open (Safe 2)
    , Cell Open (Safe 2)

    -- Rad 4
    , Cell Open (Safe 0)
    , Cell Open (Safe 0)
    , Cell Open (Safe 0)
    , Cell Open (Safe 0)
    , Cell Open (Safe 0)

    -- Rad 5
    , Cell Open (Safe 0)
    , Cell Open (Safe 0)
    , Cell Open (Safe 0)
    , Cell Open (Safe 0)
    , Cell Open (Safe 0)
    ]
```

In the [introduction](minesweeper/README.md) you saw the intended HTML structure for this `Board`.

A few points to consider:

- The `board` div has an inline styled `width` – this should be `(number of columns * 20) pixels`.
- The `board` div should have an additional class corresponding to the state of the game:

  ```elm
  case model.state of
      NotStarted ->
          "game--playing"

      Playing ->
          "game--playing"

      Won ->
          "game--finished"

      Lost ->
          "game--finished"
  ```

- The `game-info--mines` div should display the number of remaining mines (given that the player has placed its flags correctly).

- The `game-info--state` div should show some short text portraying the state of the game. We used `:)`, `:(` and `B)`.

- You can leave the `game-info--time` div empty for now.
  It will later on be used to show how long the player has been playing the current game.

- If a cell has been opened and has neighboring mines, they should have the class `cell--free-N`, where `N` is the number of mines among the eight neighboring cells.

- The cell div should also display the number of neighboring mines as its content.

When you are done, you should end up with this:

![SCREENSHOTS](/minesweeper/screenshot.png)
