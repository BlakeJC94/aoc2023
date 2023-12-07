export day05

module day05

function main()
    # part1.main()
    part2.main()
end


# %%  PART 1


module part1
# %%
using Logging

# Read mapping as list of (source_start, source_end) pairs w offset to apply
# Construct array for list starts and list ends
# For given number mask left and right arrays and combine
# One match => get ids and apply offset
# No match => no offset

function main()
    seeds, mappings = read_almanac("src/05/input.txt")
    results = apply!(seeds, mappings)
    result = minimum(results)
    println("Solution for part 1: ", result)
end

struct Map
    dest_start::Int
    source_start::Int
    range::Int

    bounds::Tuple{Int, Int}
    offset::Int

    function Map(line::String)
        dest_start, source_start, range = [parse(Int, m.match) for m in eachmatch(r"\d+", line)]
        bounds = (source_start, source_start + range - 1)
        offset = dest_start - source_start
        return new(dest_start, source_start, range, bounds, offset)
    end
end

struct Mapping
    name::String
    maps::Vector{Map}

    lmat::Matrix{Int}
    rmat::Matrix{Int}

    function Mapping(content::String, n_seeds::Int)
        maps = Map[]
        name, content = string.(split(content, ":\n"))
        for line in string.(split(content, "\n"))
            if length(line) == 0
                continue
            end
            push!(maps, Map(line))
        end

        lmat = repeat([m.bounds[1] for m in maps], 1, n_seeds)
        rmat = repeat([m.bounds[2] for m in maps], 1, n_seeds)
        return new(name, maps, lmat, rmat)
    end
end

unzip(a) = map(x->getindex.(a, x), [1, 2])

function apply!(seeds::Vector{Int}, mapping::Mapping)::Vector{Int}
    lres = seeds' .>= mapping.lmat
    rres = seeds' .<= mapping.rmat
    res = lres .* rres

    idxs = findall(res)
    map_idxs, seed_idxs = unzip(idxs)

    offsets = getfield.(mapping.maps[map_idxs], :offset)
    seeds[seed_idxs] += offsets

    return seeds
end

function apply!(seeds::Vector{Int}, mappings::Vector{Mapping})
    for (i ,mapping) in enumerate(mappings)
        seeds = apply!(seeds, mapping)
    end
    return seeds
end

function read_almanac(path::String)
    head, body... = string.(open(x -> split(read(x, String), "\n\n"), path))

    seeds = [parse(Int, m.match) for m in eachmatch(r"\d+", head)]

    mappings = Mapping[]
    for content in body
        push!(mappings, Mapping(content, length(seeds)))
    end

    return (seeds, mappings)
end

# %%
end


# %%  PART 2

module part2
using ..part1: apply!, Mapping

function read_seed_ranges(head::String)
    seed_numbers = [parse(Int, m.match) for m in eachmatch(r"\d+", head)]

    seed_starts = seed_numbers[1:2:end]
    seed_steps = seed_numbers[2:2:end]
    seed_ranges = UnitRange[]
    for (s, r) in zip(seed_starts, seed_steps)
        push!(seed_ranges, range(s,s+r-1))
    end

    return seed_ranges
end

function read_mappings(body::Vector{String}, n_seeds::Int)
    mappings = Mapping[]
    for content in body
        push!(mappings, Mapping(content, n_seeds))
    end

    return mappings
end

function main()
    @info "Reading input"

    path = "src/05/input.txt"
    head, body... = string.(open(x -> split(read(x, String), "\n\n"), path))
    seed_ranges = read_seed_ranges(head)

    result = nothing
    for (i, seed_range) in enumerate(seed_ranges)
        @info i
        @info "reading mapping"
        mappings = read_mappings(body, length(seed_range))
        @info "reading seeds"
        seeds = collect(seed_range)
        @info "applying mappings"
        results = apply!(seeds, mappings)
        result = (result === nothing) ? minimum(results) : min(result, minimum(results))
        @info "finished iter"
    end

    println("Solution for part 2: ", result)
end

end

# %%

end
# Hah no
