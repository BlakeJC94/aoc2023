using Test

# %%

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

@testset "Draw" begin
    d = Draw(1,2,3)
    @test d.r == 1
    @test d.g == 2
    @test d.b == 3
    @test Draw("3 green, 4 blue, 1 red") == Draw(1, 3, 4)
    @test Draw("5 green, 1 red") == Draw(1, 5, 0)
end

# %%

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


@testset "Game" begin
    g = Game("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
    @test g.idx == 1
    @test g.draws == Draw[Draw(4,0,3), Draw(1,2,6), Draw(0,2,0)]
end

# %%

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

foo = read_games("./example.txt")

@testset "read_games" begin
    gs = read_games("example.txt")
    for (i, g) in enumerate(gs)
        @test g.idx == i
    end
    @test gs[1].draws == Draw[Draw(4,0,3), Draw(1,2,6), Draw(0,2,0)]
    @test gs[2].draws == Draw[Draw(0, 2, 1), Draw(1, 3, 4), Draw(0, 1, 1)]
    @test gs[3].draws == Draw[Draw(20, 8, 6), Draw(4, 13, 5), Draw(1, 5, 0)]
    @test gs[4].draws == Draw[Draw(3, 1, 6), Draw(6, 3, 0), Draw(14, 3, 15)]
    @test gs[5].draws == Draw[Draw(6, 3, 1), Draw(1, 2, 2)]
end

# %%

struct Collection
    r::Int
    g::Int
    b::Int
end

function game_possible(game::Game, collection::Collection)::Bool
    for draw in game.draws
        if draw.r > collection.r || draw.g > collection.g || draw.b > collection.b
            return false
        end
    end
    return true
end

@testset "game_possible" begin
    c = Collection(12, 13, 14)
    @test game_possible(Game("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"), c) == true
    @test game_possible(Game("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"), c) == true
    @test game_possible(Game("Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"), c) == false
    @test game_possible(Game("Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"), c) == false
    @test game_possible(Game("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"), c) == true
end

# %%

function main()

    games = read_games("input.txt")
    n_cubes = Collection(12, 13, 14)

    possible_games = [game for game in games if game_possible(game, n_cubes)]

    sum_possible_indices = sum(g.idx for g in possible_games)
    println(sum_possible_indices)

end

# %%
main()
