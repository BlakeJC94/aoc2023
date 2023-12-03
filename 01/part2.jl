using Test


function main()
    lines = read_lines("./input.txt")
    values = [get_values_from_line(line) for line in lines]
    println(sum(values))
end


function read_lines(path)
    return open(path) do f
        content = read(f, String)
        lines = split(lowercase(lstrip(rstrip(content))), '\n')
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


# %%
DIGITS = Dict( "one"=>"1", "two"=>"2", "three"=>"3", "four"=>"4", "five"=>"5", "six"=>"6", "seven"=>"7", "eight"=>"8", "nine"=>"9", "zero"=>"0",)


# target = "\\d"
target = join(["\\d", keys(DIGITS)...], '|')

function get_values_from_line(line::String)::Int
    line = lowercase(line)

    rtarget = Regex(join(["^", ".*", "(", target, ")"]))
    ltarget = Regex(join(["(", target, ")", ".*", "\$"]))

    digits = []
    for target in [ltarget, rtarget]
        tmatch = match(target, line).captures[1]
        if tmatch in keys(DIGITS)
            tmatch = DIGITS[tmatch]
        end
        push!(digits, string(tmatch))
    end

    return parse(Int, join(digits))
end

@testset "get_values_from_line" begin
    @test get_values_from_line("1abc2") == 12
    @test get_values_from_line("pqr3stu8vwx") == 38
    @test get_values_from_line("a1b2c3d4e5f") == 15
    @test get_values_from_line("treb7uchet") == 77

    @test get_values_from_line("two1nine") == 29
    @test get_values_from_line("eightwothree") == 83
    @test get_values_from_line("abcone2threexyz") == 13
    @test get_values_from_line("xtwone3four") == 24
    @test get_values_from_line("4nineeightseven2") == 42
    @test get_values_from_line("zoneight234") == 14
    @test get_values_from_line("7pqrstsixteen") == 76
end
# %%

main()
