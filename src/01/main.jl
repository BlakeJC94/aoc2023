export day01

module day01

function main()
    part1.main()
    part2.main()
end

# %% COMMON

module common

function read_lines(path)
    return open(path) do f
        content = read(f, String)
        lines = split(lowercase(lstrip(rstrip(content))), '\n')
        String.(lines)
    end
    return
end

end


# %%  PART 1

module part1
using ..common

function main()
    lines = common.read_lines("./src/01/input.txt")
    values = [get_values_from_line(line) for line in lines]
    println("Solution for part 1: ", sum(values))
end

function get_values_from_line(line::String)::Int
    lmatches = match(r"^\D*(\d).*", line)
    rmatches = match(r"(\d)\D*$", line)
    digits = string(lmatches.captures[1] * rmatches.captures[1])
    return parse(Int, digits)
end

end

# %% PART 2
#
module part2
using ..common

function main()
    lines = common.read_lines("./src/01/input.txt")
    values = [get_values_from_line(line) for line in lines]
    println("Solution for part 2: ", sum(values))
end

DIGITS = Dict( "one"=>"1", "two"=>"2", "three"=>"3", "four"=>"4", "five"=>"5", "six"=>"6", "seven"=>"7", "eight"=>"8", "nine"=>"9", "zero"=>"0",)

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


end

# %% END

end
