export day09

module day09

function main()
    # part1.main()
    part2.main()
end

# %%  PART 1

module part1

function main()
    path = "src/09/input.txt"

    data = read_data(path)
    result = 0
    for seq in data
        result += diff_step(seq)
    end

    println("Solution for part 1: ", result)
end

read_data(path::String) = [[parse(Int, string(m.match)) for m in eachmatch(r"-?\d+", l)]  for l in readlines(path)]

function diff_step(seq::Vector{Int})
    # @info seq
    seq_diff = diff(seq)
    if !all(seq_diff .== 0)
        return seq[end] + diff_step(seq_diff)
    else
        return seq[end]
    end
end

end

# %%  PART 2

module part2
using ..part1: read_data, diff_step

function main()
    path = "src/09/input.txt"

    data = read_data(path)
    result = 0
    for seq in data
        result += diff_step(reverse(seq))
    end

    println("Solution for part 2: ", result)
end


end

# %%

end

