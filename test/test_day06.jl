
module testpart1
using Test
using Logging

@testset "eachnum" begin
    using AOC2023.day06.part1: eachnum
    @test eachnum("foo: 12 345 6789") == Int[12, 345, 6789]
end

@testset "read_races" begin
    using AOC2023.day06.part1: read_races, Race
    races = read_races("src/06/example.txt")
    expected_races = [Race(7, 9), Race(15, 40), Race(30, 200)]
    for (r, er) in zip(races, expected_races)
        @test r.time == er.time
        @test r.distance == er.distance
    end
end
@testset "get_valid_charge_times" begin
    using AOC2023.day06.part1: Race, get_valid_charge_times

    r = Race(7, 9)
    ts = get_valid_charge_times(r)
    @test ts == [2, 3, 4 ,5]
    @test length(ts) == 4

    for (r, l) in zip([Race(15, 40), Race(30, 200)], [8, 9])
        @test length(get_valid_charge_times(r)) == l
    end
end
end

module testpart2
using Test
using Logging

@testset "read_races" begin
    using AOC2023.day06.part1: Race
    using AOC2023.day06.part2: read_races
    races = read_races("src/06/example.txt")
    expected_races = [Race(71530, 940200)]
    for (r, er) in zip(races, expected_races)
        @test r.time == er.time
        @test r.distance == er.distance
    end
end
end
