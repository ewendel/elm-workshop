module Solution.Model exposing (..)


type alias Model =
    { game : GameState
    }


type GameState
    = Choosing Deck
    | Matching Deck Card
    | GameOver


type Msg
    = CardClicked Card
    | DeckGenerated Deck
    | RestartGame


type alias Deck =
    List Card


type alias Card =
    { id : String
    , state : CardState
    , group : Group
    }


type CardState
    = Open
    | Closed
    | Matched


type Group
    = A
    | B
