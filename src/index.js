require('./main.css');
var Elm = require('./Main.elm');

// Bug i elm-webpack-loader gjør at vi får Elm.Elm her; https://github.com/elm-community/elm-webpack-loader/issues/149
Elm.Elm.Main.init({ node: document.getElementById('root') });
