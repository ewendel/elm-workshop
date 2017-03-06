module GameGenerator exposing (generateDeck)

import Model exposing (Game, Deck, Card, Group(..), CardState(..))
import Random
import Random.List


generateDeck : Random.Generator Deck
generateDeck =
    let
        urls =
            [ "1"
            , "2"
            , "3"
            , "4"
            , "5"
            , "6"
            ]

        groupA =
            urls |> List.map (Card A Closed)

        groupB =
            urls |> List.map (Card B Closed)
    in
        List.concat [ groupA, groupB ]
            |> Random.List.shuffle
