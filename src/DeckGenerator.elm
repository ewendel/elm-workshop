module DeckGenerator exposing (random, static)

import Model exposing (Card, CardState(..), Deck, Group(..))
import Random
import Random.List


random : Random.Generator Deck
random =
    static
        |> Random.List.shuffle


static : Deck
static =
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
