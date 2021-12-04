function main()
    open("input.txt", "r") do f
        data = [parse(Int, x) for x in readlines(f)]
        differences = diff(data)
        println(count(differences .> 0))
    end
end

main()
