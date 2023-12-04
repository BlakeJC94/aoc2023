export day04

module day04
using Logging

function main()
    part1.main()
    part2.main()
end



# %%  PART 1

module part1

function main()
    cards = read_cards("src/04/input.txt")
    result = sum(c.points for c in cards)
    println("Solution for part 1: ", result)
end

function read_cards(path::String)::Vector{Card}
    cards = open(path) do f
        cards = Card[]
        for line in readlines(f)
            if length(line) > 0
                push!(cards, Card(line))
            end
        end
        return cards
    end
    return cards
end

struct Card
    idx::Int
    winning_numbers::Vector{Int}
    draw_numbers::Vector{Int}
    n_matches::Int
    points::Int
    function Card( idx::Int, winning_numbers::Vector{Int}, draw_numbers::Vector{Int}, n_matches::Int, points::Int)
        return new( idx::Int, winning_numbers::Vector{Int}, draw_numbers::Vector{Int}, n_matches::Int, points::Int)
    end
    function Card(line::String)
        header, content = split(line, ":")
        @debug "Foo $(header)"
        idx = match(r"\d+", header).match
        idx = parse(Int, string(idx))

        winning_numbers_str, draw_numbers_str = split(content, "|")
        draw_numbers_str = string(draw_numbers_str)

        draw_numbers = Int[parse(Int, m.match) for m in eachmatch(r"\d+", draw_numbers_str)]

        winning_numbers = Int[]
        points = 0
        n_matches = 0
        for m in eachmatch(r"\d+", winning_numbers_str)
            num = parse(Int, m.match)
            push!(winning_numbers, num)
            for d in draw_numbers
                if d == num
                    n_matches += 1
                    points = points == 0 ? 1 : points * 2
                end
            end
        end
        return Card(idx, winning_numbers, draw_numbers, n_matches, points)
    end
end


end


# %%  PART 2

module part2
using ..part1: Card, read_cards

function main()
    cards = read_cards("src/04/input.txt")
    n_cards = length(cards)

    copies = Dict{Int, Vector{Int}}(c.idx => Int[] for c in cards)
    counter = Dict{Int, Int}(c.idx => 1 for c in cards)
    for card in cards
        for i in 1:card.n_matches
            idx = card.idx + i
            if idx > n_cards
                continue
            end
            push!(copies[card.idx], idx)
            counter[idx] += counter[card.idx]
        end
    end
    # @info "copies[1]" copies[1]
    # @info "copies[2]" copies[2]
    # @info "copies[3]" copies[3]

    # @info "counter[1]" counter[1]
    # @info "counter[2]" counter[2]
    # @info "counter[3]" counter[3]
    result = sum(v for (_, v) in counter)
    println("Solution for part 2: ", result)
end

end

# %%

end

