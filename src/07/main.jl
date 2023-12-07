export day07

module day07

function main()
    # part1.main()
    part2.main()
end



# %%  PART 1

module part1

function main()
    hands = read_hands("src/07/input.txt")
    sort!(hands)
    result = sum(i*hand.bid for (i, hand) in enumerate(hands))
    println("Solution for part 1: ", result)
end

CARD_RANKS = [
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "T",
            "J",
            "Q",
            "K",
            "A",
           ]

HAND_RANKS = stack([
    [5,0,0,0,0], # high card
    [3,1,0,0,0], # one pair
    [1,2,0,0,0], # two pair
    [2,0,1,0,0], # three of kind
    [0,1,1,0,0], # full house
    [1,0,0,1,0], # four of kind
    [0,0,0,0,1], # five of kind
   ])

struct Hand
    cards::Vector{String}
    bid::Int

    rank_primary::Int
    # rank_secondary::Vector{Vector{Int}}
    rank_secondary::Vector{Int}

    groups::Vector{Tuple{Int}}
    function Hand(line::String)
        cards, bid, _... = string.(split(line, " "))
        bid = parse(Int, bid)
        cards = split(cards, "")

        card_idxs = map(x -> findfirst(CARD_RANKS .== x), cards)

        groups = Tuple{Int, Int}[]
        hand = zeros(Int, 5)
        for card_idx in Set(card_idxs)
            n_cards = sum(card_idxs .== card_idx)
            push!(groups, (card_idx, n_cards))
            hand[n_cards] += 1
        end
        hand_rank_primary = findfirst(all(hand .== HAND_RANKS,dims=1))[2]
        # hand_rank_secondary = [sort([g[1] for g in groups if g[2] == n]) for n in 1:5]
        hand_rank_secondary = card_idxs

        new(cards, bid, hand_rank_primary, hand_rank_secondary)
    end
end

function Base.isless(hand_a::Hand, hand_b::Hand)::Bool
    rank_a = hand_a.rank_primary
    rank_b = hand_b.rank_primary
    if rank_a != rank_b
        return (rank_a < rank_b) ? true : false
    end

    rank_a = hand_a.rank_secondary
    rank_b = hand_b.rank_secondary
    for (idx_a, idx_b) in zip(rank_a, rank_b)
        if idx_a < idx_b
            return true
        elseif idx_a > idx_b
            return false
        end
    end

end


function read_hands(path::String)
    lines = open(x->string.(eachline(x)), path)

    hands = []
    for line in lines
        if length(line) == 0
            continue
        end
        push!(hands, Hand(line))
    end

    return hands
end

end

# %%  PART 2

module part2

function main()
    hands = read_hands("src/07/input.txt")
    sort!(hands)
    result = sum(i*hand.bid for (i, hand) in enumerate(hands))
    println("Solution for part 2: ", result)
end

function read_hands(path::String)
    lines = open(x->string.(eachline(x)), path)

    hands = []
    for line in lines
        if length(line) == 0
            continue
        end
        push!(hands, Hand(line))
    end

    return hands
end

CARD_RANKS = [
            "J",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "T",
            "Q",
            "K",
            "A",
           ]



HAND_RANKS = Dict(
    [5,0,0,0,0, 0] => 1, # high card
    [3,1,0,0,0, 0] => 2, # one pair
    [1,2,0,0,0, 0] => 3, # two pair
    [2,0,1,0,0, 0] => 4, # three of kind
    [0,1,1,0,0, 0] => 5, # full house
    [1,0,0,1,0, 0] => 6, # four of kind
    [0,0,0,0,1, 0] => 7, # five of kind
    [0,2,0,0,0, 1] => 5, # full house 1 1 2 2 J
    [4,0,0,0,0, 1] => 2, # one pair  1 2 3 4 J
    [2,1,0,0,0, 1] => 4, # three of kind  1 2 3 3 J or two pair?
    [1,0,1,0,0, 1] => 6, # four of kind 1 2 2 2 J
    [0,0,0,1,0, 1] => 7, # five of kind 1 1 1 1 J
    [3,0,0,0,0, 2] => 4, # three of kind 1 2 3 J J
    [1,1,0,0,0, 2] => 6, # four of kind 1 2 2 J J
    [0,0,1,0,0, 2] => 7, # five of kind 1 1 1 J J
    [2,0,0,0,0, 3] => 6, # four of kind 1 2 J J J
    [0,1,0,0,0, 3] => 7, # five of kind 1 1 J J J
    [1,0,0,0,0, 4] => 7, # five of kind 1 J J J J
    [0,0,0,0,0, 5] => 7, # five of kind
   )


struct Hand
    cards::Vector{String}
    bid::Int

    rank_primary::Int
    rank_secondary::Vector{Int}

    groups::Vector{Tuple{Int}}
    function Hand(line::String)
        cards, bid, _... = string.(split(line, " "))
        bid = parse(Int, bid)
        cards = split(cards, "")

        card_idxs = map(x -> findfirst(CARD_RANKS .== x), cards)

        groups = Tuple{Int, Int}[]
        hand = zeros(Int, 6)
        for card_idx in Set(i for i in card_idxs if i > 1)
            n_cards = sum(card_idxs .== card_idx)
            push!(groups, (card_idx, n_cards))
            hand[n_cards] += 1
        end
        n_jokers = sum(card_idxs .== 1)
        hand[end] += n_jokers

        hand_rank_primary = HAND_RANKS[hand]
        # hand_rank_secondary = [sort([g[1] for g in groups if g[2] == n]) for n in 1:5]
        hand_rank_secondary = card_idxs

        new(cards, bid, hand_rank_primary, hand_rank_secondary)
    end
end


function Base.isless(hand_a::Hand, hand_b::Hand)::Bool
    rank_a = hand_a.rank_primary
    rank_b = hand_b.rank_primary
    if rank_a != rank_b
        return (rank_a < rank_b) ? true : false
    end

    rank_a = hand_a.rank_secondary
    rank_b = hand_b.rank_secondary
    for (idx_a, idx_b) in zip(rank_a, rank_b)
        if idx_a < idx_b
            return true
        elseif idx_a > idx_b
            return false
        end
    end

end

end

# %%

end

