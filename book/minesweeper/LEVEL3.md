# Level 3 - opening cells (aka. klikking i vinkel)

When playing Minesweeper there are two things you can do:

1. Open a cell (left click)
1. Flag a cell (right click)

There is no built-in event for right clicking in Elm, so we have done the dirty job:

```elm
onRightClick : Msg -> Attribute Msg
onRightClick message =
    Html.Events.custom
        "contextmenu"
        (Json.Decode.succeed
            { message = message
            , stopPropagation = True
            , preventDefault = True
            }
        )
```

This is used just like you would use the regular `Html.Events.onClick`.

So, what happens when you click a cell?

| Type of click | Cell state | Outcome                      |
| ------------- | ---------- | ---------------------------- |
| Right         | `Open`     | Nothing                      |
| Right         | `Closed`   | Change cell state to flagged |
| Right         | `Flagged`  | Change cell state to Closed  |
| Left          | `Open`     | Nothing                      |
| Left          | `Closed`   | See below                    |
| Left          | `Flagged`  | Nothing                      |

So, what happens when you left click a closed cell?

| Cell contents        | Outcome                                                                                                                                                                                        |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Mine`               | Set game state to `Lost` and change the cell state of all mines to `Open`                                                                                                                      |
| `Safe 0`             | When opening a cell with no neighboring mines, you should change its state to `Open`, as usual, and then open all its neighbors. For each neighbor that is also `Safe 0`, repeat this process. |
| `Safe N`, when N > 0 | Change cell state to `Open`                                                                                                                                                                    |

#### Opening `Safe 0`

The naïve way to implement opening `Safe 0` recursively might be veeeery slow in practice (and might even recurse infinitely).

- Hint: keeping track of which cells you have already checked should avoid this problem.
- Hint 2: a helper function to find the neighboring cells of a given cell might be handy.

Remember: ask for help if you get stuck – this is probably the hardest algorithm to implement when creating Minesweeper.

### Winning?

If opening a cell leads to _all_ safe cells being `Open`, you have won the game!

---

By now you should be able to play a complete game of Minesweeper with the hard-coded board.
