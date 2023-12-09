
module testpart1
using Test
using Logging

@testset "read_data" begin
    using AOC2023.day09.part1: read_data
    @test read_data("src/09/example.txt") == [
             [0, 3, 6, 9, 12, 15],
             [1, 3, 6, 10, 15, 21],
             [10, 13, 16, 21, 30, 45],
        ]
end

@testset "diff_step" begin
    using AOC2023.day09.part1: diff_step
    @test diff_step( [0, 3, 6, 9, 12, 15]) == 18
    @test diff_step( [1, 3, 6, 10, 15, 21]) == 28
    @test diff_step( [10, 13, 16, 21, 30, 45]) == 68

    @test diff_step( reverse([0, 3, 6, 9, 12, 15])) == -3
    @test diff_step( reverse([1, 3, 6, 10, 15, 21])) == 0
    @test diff_step( reverse([10, 13, 16, 21, 30, 45])) == 5
end

end


module testpart2
using Test
using Logging
end
