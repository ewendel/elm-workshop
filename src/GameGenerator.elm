module GameGenerator exposing (generateDeck)

import Model exposing (Game, Deck, Card, Group(..))
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
            urls |> List.map (Card A False)

        groupB =
            urls |> List.map (Card B False)
    in
        List.concat [ groupA, groupB ]
            |> Random.List.shuffle
