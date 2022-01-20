import './main.css';
import { Elm } from './Main.elm';


const node = document.querySelector("#app div")
Elm.Main.init({ node: node });
