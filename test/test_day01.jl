using Test

@testset "read_lines" begin
    using AOC2023.day01.part1: read_lines
    @test read_lines("./src/01/example.txt") == [
         "1abc2"
         "pqr3stu8vwx"
         "a1b2c3d4e5f"
         "treb7uchet"
    ]
end

@testset "part 1 get_values_from_line" begin
    using AOC2023.day01.part1: get_values_from_line as get_values_from_line_1
    @test get_values_from_line_1("1abc2") == 12
    @test get_values_from_line_1("pqr3stu8vwx") == 38
    @test get_values_from_line_1("a1b2c3d4e5f") == 15
    @test get_values_from_line_1("treb7uchet") == 77
end

@testset "part 2 get_values_from_line" begin
    using AOC2023.day01.part2: get_values_from_line as get_values_from_line_2
    @test get_values_from_line_2("1abc2") == 12
    @test get_values_from_line_2("pqr3stu8vwx") == 38
    @test get_values_from_line_2("a1b2c3d4e5f") == 15
    @test get_values_from_line_2("treb7uchet") == 77

    @test get_values_from_line_2("two1nine") == 29
    @test get_values_from_line_2("eightwothree") == 83
    @test get_values_from_line_2("abcone2threexyz") == 13
    @test get_values_from_line_2("xtwone3four") == 24
    @test get_values_from_line_2("4nineeightseven2") == 42
    @test get_values_from_line_2("zoneight234") == 14
    @test get_values_from_line_2("7pqrstsixteen") == 76
end
