function filter_occur(bins, idx, order)
    more_zero = count(==('0'), bins .|> x -> x[idx]) > length(bins) / 2
    char_filter = (!more_zero) ⊻ order ? '1' : '0'
    filter(x -> x[idx] == char_filter, bins)
end

function main()
    open(ARGS[1], "r") do f
        data = [l for l in readlines(f)]
        rows = length(data)
        cols = length(data[1])
        flattened = [parse(UInt8, x) for l in data for x in l]
        matrix = transpose(reshape(flattened, cols, rows))

        mosts = leasts = data

        for (idx, _) in data[1] |> enumerate
            length(mosts) > 1 && (mosts = filter_occur(mosts, idx, false))
            length(leasts) > 1 && (leasts = filter_occur(leasts, idx, true))
        end
        println(parse(Int, mosts[1], base=2) * parse(Int, leasts[1], base=2))
    end
end


if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
