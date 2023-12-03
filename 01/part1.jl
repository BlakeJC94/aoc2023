
function main()
    lines = read_lines("./input.txt")
    values = [get_values_from_line(line) for line in lines]
    println(sum(values))
end


function read_lines(path)
    return open(path) do f
        content = read(f, String)
        lines = split(lstrip(rstrip(content)), '\n')
        String.(lines)
    end
    return
end


@testset "read_lines" begin
    @test read_lines("./example.txt") == [
         "1abc2"
         "pqr3stu8vwx"
         "a1b2c3d4e5f"
         "treb7uchet"
    ]
end

function get_values_from_line(line::String)::Int
    lmatches = match(r"^\D*(\d).*", line)
    rmatches = match(r"(\d)\D*$", line)
    digits = string(lmatches.captures[1] * rmatches.captures[1])
    return parse(Int, digits)
end

using Test

@testset "get_values_from_line" begin
    @test get_values_from_line("1abc2") == 12
    @test get_values_from_line("pqr3stu8vwx") == 38
    @test get_values_from_line("a1b2c3d4e5f") == 15
    @test get_values_from_line("treb7uchet") == 77
end

main()
