module Model exposing (..)


type alias Score =
    Int


type GameState
    = NotStarted
    | Choosing Deck
    | Matching Deck Card
    | GameOver Deck


type alias Card =
    { group : Group
    , open : Bool
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
