-- Model.elm


module Model exposing (Card, GameState(..), Model, Msg(..))


type GameState
    = Choosing Deck
    | Matching Deck Card
    | GameOver


type alias Model =
    { game : GameState }


type Msg
    = CardClicked Card
    | DeckGenerated Deck
    | RestartGame


type alias Card =
    { id : String
    , group : Group
    , state : CardState
    }
