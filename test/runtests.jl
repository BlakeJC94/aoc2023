using Test
using ArgParse
using Logging

function parse_cli()
    s = ArgParseSettings()
    @add_arg_table s begin
        "day"
            help = "selected day to run tests for"
            arg_type = Int
    end

    return parse_args(ARGS, s)
end

function main()
    args = parse_cli()
    if args["day"] === nothing
        @info "Running all tests"
        for fp in readdir("./test")
            if startswith(fp, "test_")
                @info "Running $(fp)"
                include("./$(fp)")
            end
        end
    else
        day_idx = lpad(string(args["day"]), 2, "0")
        day_fp = "test_day$(day_idx).jl"
        @info "Running $(day_fp)"
        include("./$(day_fp)")
    end

end


if !isdefined(Base, :active_repl)
    main()
end
