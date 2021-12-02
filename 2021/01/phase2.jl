function main()
    open("input.txt", "r") do f
        data = [parse(Int, x) for x in readlines(f)]
        sums = zeros(length(data) - 2)
        for i in 1:(length(data) - 2)
            sums[i] = sum(data[i:i+2])
        end
        differences = diff(sums)
        println(count(differences .> 0))
    end
end

main()
