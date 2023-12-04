using ArgParse
using AOC2023


function parse_cli()
    s = ArgParseSettings()
    @add_arg_table s begin
        "day"
            help = "a positional argument"
            arg_type = Int
            required = true
    end

    return parse_args(ARGS, s)
end

entrypoints = Dict(
    1=>AOC2023.day01.main,
    2=>AOC2023.day02.main,
    3=>AOC2023.day03.main,
    4=>AOC2023.day04.main,
)

function main()
    args = parse_cli()
    entrypoints[args["day"]]()
end

if !isdefined(Base, :active_repl)
    main()
end
