export day03

module day03

function main()
    part1.main()
    part2.main()
end


# %%  PART 1

module part1

function main()
    vals = Int[]
    for buffer in BufferSource("src/03/input.txt")
        vals = vcat(vals, read(buffer))
    end

    result = sum(vals)
    println("Solution for part 1: ", result)
end

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


# for buffer in BufferSource("src/03/example.txt")
#     println(buffer)
# end

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

end


# %%  PART 2

module part2

function main()
    results = Dict{Tuple{Int, Int}, Vector{Int}}()
    for buffer in BufferSource("src/03/input.txt")
        vals = read(buffer)
        for val in vals
            if !(val.idx in keys(results))
                results[val.idx] = Int[]
            end
            push!(results[val.idx], val.number)
        end
    end

    result = 0
    for (k, v) in results
        if length(v) == 2
            result += v[1] * v[2]
        end
    end
    println("Solution for part 2: ", result)
end

struct BufferSource
    data::Vector{String}
    BufferSource(c::Vector{String}) = new(c)
    BufferSource(path::String) = new([l for l in readlines(path) if length(l) > 0])
end

struct Buffer
    line_idx::Int
    line::String
    data::Vector{String}
    Buffer(i::Int, d::Vector{String}) = new(i, d[2], d)
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

    return (Buffer(state, buffer), state+1)
end

# for buffer in BufferSource("example.txt")
#     println(buffer)
# end

struct Value
    number::Int
    idx::Tuple{Int,Int}
end


function read(b::Buffer)::Vector{Value}
    out = Value[]
    for m in eachmatch(r"\d+", b.line)
        val = m.match

        l_ind = max(m.offset - 1, 1)
        r_ind = min(m.offset + length(m.match), length(b.line))

        for (l, offset) in zip(b.data, [-1, 0, 1])
            m_star = match(r"\*", l[l_ind:r_ind])
            if m_star != nothing
                value = Value(parse(Int, val), (b.line_idx + offset,  l_ind - 1 + m_star.offset))
                push!(out, value)
            end
        end
    end

    return out
end

# for buffer in BufferSource("example2.txt")
#     println(read(buffer))
# end

end

end
