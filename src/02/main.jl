export day02

module day02

function main()
    part1.main()
    part2.main()
end



# %%  PART 1

module part1

function main()
    games = read_games("./src/02/input.txt")
    n_cubes = Collection(12, 13, 14)

    possible_games = [game for game in games if game_possible(game, n_cubes)]

    sum_possible_indices = sum(g.idx for g in possible_games)
    println("Solution for part 1: ", sum_possible_indices)
end

struct Draw
    r::Int
    g::Int
    b::Int

    Draw(r::Int, g::Int, b::Int) = new(r, g, b)
    function Draw(line::String)
        result = Dict("r"=>0, "g"=>0, "b"=>0)
        for part in split(line, ", ")
            n, colour = split(part, " ")
            result[string(colour[:1])] = parse(Int, n)
        end
        return new(
            result["r"],
            result["g"],
            result["b"],
        )
    end
end

struct Collection
    r::Int
    g::Int
    b::Int
    Collection(a::Int, b::Int, c::Int) = new(a,b,c)
    Collection(d::Draw) = new(d.r, d.g, d.b)
end

struct Game
    idx::Int
    draws::Vector{Draw}

    Game(idx::Int, draws::Vector{Draw}) = new(idx, draws)
    function Game(line::String)
        header, content = split(line, ": ")

        _, idx = split(header, " ")
        idx = parse(Int, idx)

        draws = Draw[]
        for drawstr in split(content, "; ")
            push!(draws, Draw(string(drawstr)))
        end

        return new(idx, draws)
    end
end

function read_games(path::String)
    lines = open(path) do f
        content = read(f, String)
        content = rstrip(lstrip(content))
        split(content, '\n')
    end

    games = []
    for line in lines
        push!(games, Game(string(line)))
    end

    return games
end


function game_possible(game::Game, collection::Collection)::Bool
    for draw in game.draws
        if draw.r > collection.r || draw.g > collection.g || draw.b > collection.b
            return false
        end
    end
    return true
end

end

# %% PART 2

module part2
using ..part1: Collection, Game, Draw, read_games

function main()
    games = read_games("./src/02/input.txt")
    min_collections = [minimum_collection(g) for g in games]

    powers = [c.r * c.g * c.b for c in min_collections]

    result = sum(powers)
    println("Solution for part 2: ", result)
end

# TODO Why couldn't I write a new max?
function max_col(a::Collection, b::Collection)
    return Collection(
                      max(a.r, b.r),
                      max(a.g, b.g),
                      max(a.b, b.b),
                     )
end

function minimum_collection(game::Game)::Collection
    result = Collection(0,0,0)
    for draw in game.draws
        result = max_col(result, Collection(draw))
    end
    return result
end

end

# %% END

end

