# Round Three - Minesweeper

What's cooler than having made _two_ games? _Three_ games!

Before we start, head on over to the `minesweeper` folder, install dependencies and start it up.

```sh
$ cd mineseweeper
$ npm install
$ npm start
```

This will be an even more open task than Snake.
If you want to just dive in and try to figure it out all by yourself, go ahead!
We have pulled a sample of the HTML used in the finished version that you can use as a base and see which CSS classes to use etc. You will find this below.

If you get stuck and want som help, head on over to [Level 1](minesweeper/LEVEL1.md).

```html
<div class="game">
  <div class="game-info">
    <div class="game-info--mines">1</div>
    <button class="game-info--state">:(</button>
    <div class="game-info--time">10</div>
  </div>
  <div class="board game--finished" style="width: 100px;">
    <button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-1" disabled="">1</button
    ><button class="cell cell--closed cell--flagged">!</button
    ><button class="cell cell--closed" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-1" disabled="">1</button
    ><button class="cell cell--open cell--mine" disabled="">*</button
    ><button class="cell cell--open cell--mine" disabled="">*</button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-1" disabled="">1</button
    ><button class="cell cell--open cell--free-2" disabled="">2</button
    ><button class="cell cell--open cell--free-2" disabled="">2</button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button
    ><button class="cell cell--open cell--free-0" disabled=""></button>
  </div>
</div>
```
