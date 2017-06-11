## Level 2 - View

If we have a `Model` we can also create our view function!
Recall that it should have the signature: `view : Model -> Html a`.

The HTML structure we want is this:

```html
<div class="map">
  <div class="row">
    <span class="tile {TILECLASSNAME}" />
    <span class="tile {TILECLASSNAME}" />
    ...
  </div>
  <div class="row">
    <span class="tile {TILECLASSNAME}" />
    <span class="tile {TILECLASSNAME}" />
    ...
  </div>
  ...
</div>
```
where `{TILECLASSNAME}` should be one of theses:
* `snake`
* `food`
* `wall`
* `open`

This is, of course, when when the snake is alive.
If the snake is dead, you should show some nice message and a button for restarting the game.
