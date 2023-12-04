using Test

@testset "read_lines" begin
    @test AOC2023.day01.common.read_lines("./src/01/example.txt") == [
         "1abc2"
         "pqr3stu8vwx"
         "a1b2c3d4e5f"
         "treb7uchet"
    ]
end

@testset "part 1 get_values_from_line" begin
    @test AOC2023.day01.part1.get_values_from_line("1abc2") == 12
    @test AOC2023.day01.part1.get_values_from_line("pqr3stu8vwx") == 38
    @test AOC2023.day01.part1.get_values_from_line("a1b2c3d4e5f") == 15
    @test AOC2023.day01.part1.get_values_from_line("treb7uchet") == 77
end

@testset "part 2 get_values_from_line" begin
    @test AOC2023.day01.part2.get_values_from_line("1abc2") == 12
    @test AOC2023.day01.part2.get_values_from_line("pqr3stu8vwx") == 38
    @test AOC2023.day01.part2.get_values_from_line("a1b2c3d4e5f") == 15
    @test AOC2023.day01.part2.get_values_from_line("treb7uchet") == 77

    @test AOC2023.day01.part2.get_values_from_line("two1nine") == 29
    @test AOC2023.day01.part2.get_values_from_line("eightwothree") == 83
    @test AOC2023.day01.part2.get_values_from_line("abcone2threexyz") == 13
    @test AOC2023.day01.part2.get_values_from_line("xtwone3four") == 24
    @test AOC2023.day01.part2.get_values_from_line("4nineeightseven2") == 42
    @test AOC2023.day01.part2.get_values_from_line("zoneight234") == 14
    @test AOC2023.day01.part2.get_values_from_line("7pqrstsixteen") == 76
end
