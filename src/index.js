import './main.css';
import { Elm } from './Main.elm';


const node = document.querySelector("#app div")
// Bug i elm-webpack-loader gjør at vi får Elm.Elm her; https://github.com/elm-community/elm-webpack-loader/issues/149
Elm.Main.init({ node: node });
