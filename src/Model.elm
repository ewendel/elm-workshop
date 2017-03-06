module Model exposing (..)


type alias Score =
    Int


type GameState
    = NotStarted
    | Choosing Deck
    | Matching Deck Card
    | GameOver Deck


type CardState
    = Closed
    | Open
    | Matched


type alias Card =
    { group : Group
    , state : CardState
    , id : String
    }


type Group
    = A
    | B


type alias Deck =
    List Card


type alias Game =
    { cards : List Card
    }


type alias Model =
    { game : GameState
    }


type Msg
    = StartGameClick
    | DeckGenerated Deck
    | CardClick Card
    | GameTimeout
