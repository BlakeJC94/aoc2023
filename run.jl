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

function main()
    args = parse_cli()
    if args["day"] == 1
        AOC2023.day01.main()
    elseif args["day"] == 2
        AOC2023.day02.main()
    elseif args["day"] == 3
        AOC2023.day03.main()
    end
end

if !isdefined(Base, :active_repl)
    main()
end
