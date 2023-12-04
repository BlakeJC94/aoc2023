using ArgParse
using AOC2023


function parse_cli()
    s = ArgParseSettings()
    @add_arg_table s begin
        "day"
            help = "selected day to run solutions for"
            arg_type = Int
            required = true
    end

    return parse_args(ARGS, s)
end

function main()
    args = parse_cli()
    AOC2023.entrypoints[args["day"]]()
end

if !isdefined(Base, :active_repl)
    main()
end
