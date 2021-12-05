function main()
    open(ARGS[1], "r") do f
        γ, ϵ::UInt64 = 0, 0
        data = [l for l in readlines(f)]
        rows = length(data)
        cols = length(data[1])
        flattened = [parse(UInt8, x) for l in data for x in l]
        matrix = transpose(reshape(flattened, cols, rows))

        for c in 1:cols
            gamma_marker = sum(matrix[:,c]) > (rows / 2) ? 1 : 0
            epsilon_marker = gamma_marker == 0 ? 1 : 0
            γ += gamma_marker << (cols - c)
            ϵ += epsilon_marker << (cols - c)
        end

        println(γ * ϵ)
    end
end


if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
