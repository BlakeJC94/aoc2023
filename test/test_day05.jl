using Test

# Good lord this one was a mess!

# @testset "State" begin
#     using AOC2023.day05.part1: State
#     @test State(3).number == 3
# end

# @testset "Map" begin
#     using AOC2023.day05.part1: Map

#     m1 = Map("50 98 2")
#     @test m1.dest_start == 50
#     @test m1.source_start == 98
#     @test m1.range == 2

#     m2 = Map("52 50 48")
#     @test m2.dest_start == 52
#     @test m2.source_start == 50
#     @test m2.range == 48
# end

# @testset "Mapping" begin
#     using AOC2023.day05.part1: Mapping
#     m = Mapping("foo", [Map("50 98 2"), Map("52 50 48")])
#     @test m._mapping[1] == ((50, 98), 2)
#     @test m._mapping[2] == ((98, 100), -48)
# end

# using Logging

# @testset "Mapping" begin
#     using AOC2023.day05.part1: read_file
#     states, mappings = read_file("./src/05/example.txt")

#     expected_states = [79, 14, 55, 13]
#     expected_names = [
#         "seed-to-soil map",
#         "soil-to-fertilizer map",
#         "fertilizer-to-water map",
#         "water-to-light map",
#         "light-to-temperature map",
#         "temperature-to-humidity map",
#         "humidity-to-location map",
#     ]

#     for (state, expected) in zip(states, expected_states)
#         @test state.number == expected
#     end
#     for (mapping, expected) in zip(mappings, expected_names)
#         @test mapping.name == expected
#     end
# end
