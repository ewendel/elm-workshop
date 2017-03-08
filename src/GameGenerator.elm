module GameGenerator exposing (generateDeck, staticDeck)

import Model exposing (Deck, Card, Group(..), CardState(..))
import Random
import Random.List


generateDeck : Random.Generator Deck
generateDeck =
    staticDeck
        |> Random.List.shuffle


staticDeck : Deck
staticDeck =
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
            urls |> List.map (\url -> { id = url, group = A, state = Closed })

        groupB =
            urls |> List.map (\url -> { id = url, group = B, state = Closed })
    in
        List.concat [ groupA, groupB ]
