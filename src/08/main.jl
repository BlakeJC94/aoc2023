export day08

module day08

function main()
    # part1.main()
    part2.main()
end

# %%  PART 1

module part1

function main()
    directions, doc_map = read_doc("src/08/input.txt")

    location = "AAA"
    dest = "ZZZ"
    max_steps = Int(1e5)

    steps = 0
    @info "starting search"
    while (location != dest)
        if steps > max_steps
            @error "max_steps exceeded"
            break
        end
        dir = directions[1 + (steps % (length(directions)))]
        location = doc_map[location][dir]
        steps += 1
    end

    result = steps
    println("Solution for part 1: ", result)
end

function read_doc(path::String)
    head, content = open((x->split(read(x, String), "\n\n")), path)
    directions = [((x == 'L') ? 1 : 2) for x in head]

    doc_map = Dict{String, Tuple{String, String}}()

    for line in split(content, "\n")
        if length(line) == 0
            continue
        end
        a, b, c = map((x -> x.match |> string),eachmatch(r"\w+", string(line)))
        doc_map[a] = (b, c)
    end

    return directions, doc_map
end


end


# %%  PART 2

module part2
using ..part1: read_doc

function get_locations(doc_map::Dict{String, Tuple{String, String}}, location::String)
    return [k for (k, _) in doc_map if endswith(k, location)]
end

MAX_STEPS = Int(1e9)


function dist(
        location::String, # len3
        dest::String,  # and be len1 or len3
        doc_map::Dict{String, Tuple{String, String}},
        directions::Vector{Int},
    )
    steps = 0
    while (steps == 0) | !endswith(location, dest)
        if steps > MAX_STEPS
            @error "max_steps exceeded"
            break
        end
        dir = directions[1 + (steps % (length(directions)))]
        location = doc_map[location][dir]
        steps += 1
    end
    return steps
end


function main()
    directions, doc_map = read_doc("src/08/input.txt")

    location = "A"
    dest = "Z"

    locations = sort(get_locations(doc_map, location))
    result = lcm(map(x->dist(x, dest, doc_map, directions), locations)...)
    println("Solution for part 2: ", result)
end

# Wouldn;t work in the general case, but seems to work with this crafted input... why?
# Each *A location maps to a (unique) *Z location after X steps, and X is divisible by n_dirs
# And each *Z maps to itself after X as well, so it's a nicely periodic input

# Hence, the *Z all intersect at LCM of of each X

end

# %%

end

