module AOC2023


export entrypoints

entrypoints = Dict()
for fp in readdir("./src")
    if match(r"^\d+$", fp) === nothing
        continue
    end
    include("./$(fp)/main.jl")
    expr = Meta.parse("day$(fp).main")
    entrypoints[parse(Int, fp)] = eval(expr)
end

end
