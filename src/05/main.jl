export day05
using Logging

module day05

function main()
    # part1.main()
    part2.main()
end



# %%  PART 1
module part1


function main()

    almanac = Almanac("./src/05/input.txt")

    # apply!(almanac.states[1], almanac.mappings)
    # @info almanac.states[1].history

    for seed in almanac.states
        apply!(seed, almanac.mappings)
    end
    # for s in almanac.states
    #     @info length(s.history) s.history[1] s.history[end]
    # end

    result = min([s.number for s in almanac.states]...)
    println("Solution for part 1: ", result)
end

mutable struct State
    number::Int
    history::Vector{Tuple{String,Int}}

    State(number::Int) = new(number, Tuple{String,Int}[("seed", number)])
end

struct Map
    dest_start::Int
    source_start::Int
    range::Int

    _bounds::Tuple{Int, Int}
    _offset::Int

    function Map(line::String)
        dest_start, source_start, range = [parse(Int, m.match) for m in eachmatch(r"\d+", line)]
        bounds = (source_start, source_start + range - 1)
        offset = dest_start - source_start
        return new(dest_start, source_start, range, bounds, offset)
    end
end

function apply(number::Int, map::Map)::Int
    result = number
    if (number >= map._bounds[1]) & (number <= map._bounds[2])
        # @info number map._bounds number >= map._bounds[1]  number <= map._bounds[2]
        result = number + map._offset
    end
    # @info map ":" number "->" result
    return result
end


# let i be the input and k be the output (dest is i + k)
# if i < source_start or i > source_start + range
#   return k = 0
# else
#   return k = dest_start - source_start
#
#
# source_start, stource_start + range |-> dest_start - source_start
struct Mapping
    name::String
    maps::Vector{Map}

    function Mapping(content::String)
        maps = Map[]
        name, content = string.(split(content, ":\n"))
        for line in string.(split(content, "\n"))
            if length(line) == 0
                continue
            end
            push!(maps, Map(line))
        end
        return new(name, maps)
    end
end

struct Almanac
    states::Vector{State}
    mappings::Vector{Mapping}
    function Almanac(path::String)
        head, body... = string.(open(x -> split(read(x, String), "\n\n"), path))
        seeds = [State(parse(Int, m.match)) for m in eachmatch(r"\d+", head)]
        mappings = Mapping[]
        for content in body
            push!(mappings, Mapping(string(content)))
        end
        return new(seeds, mappings)
    end
end

function update!(state::State, name::String, result::Int)
    state.number = result
    push!(state.history, (name, result))
end

function apply!(state::State, mapping::Mapping)
    # @info "HELLO"
    result = state.number
    for map in mapping.maps
        result = apply(state.number, map)
        # @info result
        if result != state.number
            # @info "BREAK"
            break
        end
    end
    name = string(split(mapping.name, " ")[1])
    name = string(split(name, "-")[3])
    update!(state, name, result)
end

function apply!(state::State, mappings::Vector{Mapping})
    # apply!(state, mappings[1])
    for mapping in mappings
        apply!(state, mapping)
    end
end



end

# %%  PART 2

module part2
using ..part1: State, Mapping, Map

struct Almanac
    seeds::Vector{UnitRange}
    mappings::Vector{Mapping}
    function Almanac(path::String)
        head, body... = string.(open(x -> split(read(x, String), "\n\n"), path))

        seed_numbers = [parse(Int, m.match) for m in eachmatch(r"\d+", head)]

        seed_starts = seed_numbers[1:2:end]
        seed_ranges = seed_numbers[2:2:end]
        seeds = UnitRange[]
        for (s, r) in zip(seed_starts, seed_ranges)
            push!(seeds, range(s,s+r-1))
        end

        # seeds = [State(parse(Int, m.match)) for m in eachmatch(r"\d+", head)]
        mappings = Mapping[]
        for content in body
            push!(mappings, Mapping(string(content)))
        end
        return new(seeds, mappings)
    end
end

function apply(number::Int, map::Map)::Int
    result = number
    if (number >= map._bounds[1]) & (number <= map._bounds[2])
        # @info number map._bounds number >= map._bounds[1]  number <= map._bounds[2]
        result = number + map._offset
    end
    # @info map ":" number "->" result
    return result
end


function apply(number::Int, mapping::Mapping)::Int
    result = number
    for map in mapping.maps
        result = apply(number, map)
        # @info result
        if result != number
            # @info "BREAK"
            break
        end
    end
    # name = string(split(mapping.name, " ")[1])
    # name = string(split(name, "-")[3])
    # @info mapping.name
    return result
end

function apply(number::Int, mappings::Vector{Mapping})::Int
    result = number
    for mapping in mappings
        result = apply(result, mapping)
    end
    return result
end

function main()

    almanac = Almanac("./src/05/input.txt")

    # @info almanac.mappings
    # foo = 79:92
    # foo = 82:82
    # @info collect(foo)
    # # for i in 1:length(almanac.mappings)
    # #     foo = apply.(foo, tuple(almanac.mappings[i]))
    # #     @info foo
    # # end
    # foo = apply.(foo, tuple(almanac.mappings))
    # @info foo

    result = nothing
    for (i, seed_range) in enumerate(almanac.seeds)
        # @info i seed_range
        _out = apply.(seed_range, tuple(almanac.mappings))
        # @info _out
        out = minimum(_out)
        # @info out
        if result === nothing
            result = out
        else
            result = min(result, out)
        end
    end
    println("Solution for part 2: ", result)
end




end

# %%

end

