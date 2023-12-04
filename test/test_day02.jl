using Test

@testset "Draw" begin
    using AOC2023.day02.part1: Draw

    d = Draw(1,2,3)
    @test d.r == 1
    @test d.g == 2
    @test d.b == 3
    @test Draw("3 green, 4 blue, 1 red") == Draw(1, 3, 4)
    @test Draw("5 green, 1 red") == Draw(1, 5, 0)
end

@testset "Game" begin
    using AOC2023.day02.part1: Game

    g = Game("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
    @test g.idx == 1
    @test g.draws == Draw[Draw(4,0,3), Draw(1,2,6), Draw(0,2,0)]
end


@testset "read_games" begin
    using AOC2023.day02.part1: Game, Draw, read_games

    gs = read_games("src/02/example.txt")
    for (i, g) in enumerate(gs)
        @test g.idx == i
    end
    @test gs[1].draws == Draw[Draw(4,0,3), Draw(1,2,6), Draw(0,2,0)]
    @test gs[2].draws == Draw[Draw(0, 2, 1), Draw(1, 3, 4), Draw(0, 1, 1)]
    @test gs[3].draws == Draw[Draw(20, 8, 6), Draw(4, 13, 5), Draw(1, 5, 0)]
    @test gs[4].draws == Draw[Draw(3, 1, 6), Draw(6, 3, 0), Draw(14, 3, 15)]
    @test gs[5].draws == Draw[Draw(6, 3, 1), Draw(1, 2, 2)]
end

@testset "game_possible" begin
    using AOC2023.day02.part1: Game, game_possible, Collection

    c = Collection(12, 13, 14)
    @test game_possible(Game("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"), c) == true
    @test game_possible(Game("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"), c) == true
    @test game_possible(Game("Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"), c) == false
    @test game_possible(Game("Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"), c) == false
    @test game_possible(Game("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"), c) == true
end

@testset "mininum_collection" begin
    using AOC2023.day02.part2: minimum_collection, Game, Collection
    @test minimum_collection(Game("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")) == Collection(4,2,6)
    @test minimum_collection(Game("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue")) == Collection(1,3,4)
    @test minimum_collection(Game("Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red")) == Collection(20, 13,6)
    @test minimum_collection(Game("Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red")) == Collection(14,3,15)
    @test minimum_collection(Game("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green")) == Collection(6,3,2)
end
