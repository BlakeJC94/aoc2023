module AOC2023

export day01
include("01/main.jl")

export day02
include("02/main.jl")

export day03
include("03/main.jl")

export day04
include("04/main.jl")

export entrypoints
entrypoints = Dict(
    1=>day01.main,
    2=>day02.main,
    3=>day03.main,
    4=>day04.main,
)

end
