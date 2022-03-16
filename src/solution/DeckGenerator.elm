module Solution.DeckGenerator exposing (random, static)

import Random
import Random.List
import Solution.Model exposing (CardState(..), Deck, Group(..))


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
