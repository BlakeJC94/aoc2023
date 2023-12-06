export day06

module day06

function main()
    part1.main()
    part2.main()
end



# %%  PART 1

module part1

function main()
    races = read_races("src/06/input.txt")
    result = prod([length(get_valid_charge_times(r)) for r in races])
    println("Solution for part 1: ", result)
end

struct Race
    time::Int
    distance::Int
end

eachnum(line::AbstractString)::Vector{Int} = [parse(Int, m.match) for m in eachmatch(r"\d+", line)]

function read_races(path::String)::Vector{Race}
    time_line, dist_line, _... = open(x -> split(read(x, String), "\n") .|> string, path)
    return [Race(t, d) for (t, d) in zip(eachnum(time_line), eachnum(dist_line))]
end

dist(charge_time::Int, total_time::Int)::Int = (total_time - charge_time) * charge_time

# Using quadratic formula, solution is fairly simple
function get_valid_charge_times_bounds(race::Race)::Vector{Int}
    T, D = race.time, race.distance
    deltasq = T^2 - 4*D
    if deltasq < 0  # No solutions
        return Int[]
    elseif (deltasq == 0) & (T % 2 == 0)  # Catch single solution if it occurs in t state space
        return Int[T/2]
    end
    delta = sqrt(deltasq)
    t1, t2 = ((T - delta) / 2), ((T + delta) / 2)
    if t1 % 1 == 0
        t1 = t1 + 1
    end
    if t2 % 1 == 0
        t2 = t2 - 1
    end
    return Int[ceil(t1), floor(t2)]
end

function get_valid_charge_times(race::Race)::Vector{Int}
    ts = get_valid_charge_times_bounds(race)
    n = length(ts)
    if n < 2
        return ts
    else
        return collect(Int.(range(ts...)))
    end
end


end


# %%  PART 2

module part2
using ..part1: Race, get_valid_charge_times_bounds

function read_races(path::String)::Vector{Race}
    time_line, dist_line, _... = open(x -> split(read(x, String), "\n") .|> string, path)
    time_digits = join([m.match for m in eachmatch(r"\d+", time_line)])
    dist_digits = join([m.match for m in eachmatch(r"\d+", dist_line)])
    return [Race(parse(Int, time_digits), parse(Int, dist_digits))]
end

function main()
    races = read_races("src/06/input.txt")
    result = get_valid_charge_times_bounds(races[1])
    result = (length(result) < 2) ? length(result) : result[2] - result[1] + 1
    println("Solution for part 2: ", result)
end

end

# %%

end

