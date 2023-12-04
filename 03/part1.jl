using Test

# Init sum
# Read in file contents
# For each line
# Load buffer (+/- 1 line)
# Read numbers in line
# For each number
# Assign coords for symbols
# Check buffer for hits
# Add numbers to sum

# %%

struct BufferSource
    data::Vector{String}
    BufferSource(c::Vector{String}) = new(c)
    BufferSource(path::String) = new([l for l in readlines(path) if length(l) > 0])
end

struct Buffer
    line::String
    data::Vector{String}
    Buffer(d::Vector{String}) = new(d[2], d)
end


function Base.iterate(b::BufferSource, state=1)
    n = length(b.data)
    if state > n
        return nothing
    end
    min_idx = max(1, state-1)
    max_idx = min(n, state+1)

    l = length(b.data[state])
    buffer = String[]
    if state == 1
        push!(buffer, repeat(".", l))
    end
    buffer = vcat(buffer, b.data[min_idx:max_idx])
    if state == length(b.data)
        push!(buffer, repeat(".", l))
    end

    return (Buffer(buffer), state+1)
end


# for buffer in BufferSource("example.txt")
#     println(buffer)
# end


# %%

function read(b::Buffer)::Vector{Int}
    out = Int[]
    for m in eachmatch(r"\d+", b.line)
        val = m.match

        l_ind = max(m.offset - 1, 1)
        r_ind = min(m.offset + length(m.match), length(b.line))

        marked = false
        for l in b.data
            if match(r"[^\d\.]", l[l_ind:r_ind]) != nothing
                marked = true
                break
            end
        end

        if marked
            push!(out, parse(Int, val))
        end
    end
    return out
end

# for buffer in BufferSource("example.txt")
#     println(read(buffer))
# end


# %%

function main()

    vals = Int[]
    for buffer in BufferSource("input.txt")
        vals = vcat(vals, read(buffer))
    end

    result = sum(vals)

    println(result)

end

main()
