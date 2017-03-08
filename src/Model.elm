module Model exposing (..)


type GameState
    = Choosing Deck
    | Matching Deck Card
    | GameOver


type alias Model =
    { game : GameState
    }


type Msg
    = CardClicked Card
    | RestartGame


type CardState
    = Open
    | Closed
    | Matched


type alias Deck =
    List Card


type Group
    = A
    | B


type alias Card =
    { id : String
    , group : Group
    , state : CardState
    }
