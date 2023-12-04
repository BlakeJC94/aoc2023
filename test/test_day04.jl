using Test

@testset "Card" begin
    using AOC2023.day04.part1: Card
    examples = [
        (Card("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"), Card(1, Int[41, 48, 83, 86, 17], Int[83, 86,  6, 31, 17,  9, 48, 53], 3, 8)),
        (Card("Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19"), Card(2, Int[13, 32, 20, 16, 61], Int[61, 30, 68, 82, 17, 32, 24, 19], 2, 2)),
        (Card("Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1"), Card(3, Int[ 1, 21, 53, 59, 44], Int[69, 82, 63, 72, 16, 21, 14,  1], 2, 2)),
        (Card("Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83"), Card(4, Int[41, 92, 73, 84, 69], Int[59, 84, 76, 51, 58,  5, 54, 83], 1, 1)),
        (Card("Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36"), Card(5, Int[87, 83, 26, 28, 32], Int[88, 30, 70, 12, 93, 22, 82, 36], 0, 0)),
        (Card("Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"), Card(6, Int[31, 18, 13, 56, 72], Int[74, 77, 10, 23, 35, 67, 36, 11], 0, 0)),
    ]
    for (out, expected) in examples
        @test out.idx == expected.idx
        @test out.winning_numbers == expected.winning_numbers
        @test out.draw_numbers == expected.draw_numbers
        @test out.points == expected.points
    end
end
