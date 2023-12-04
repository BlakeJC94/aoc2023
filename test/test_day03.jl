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
