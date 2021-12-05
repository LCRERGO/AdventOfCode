
function main()
    MAX = 1000;
    open(ARGS[1], "r") do f
        diagram = zeros(UInt8, MAX, MAX)
        for line ∈ readlines(f)
            origin, des = split(line, "->")
            x_or, y_or = parse.(UInt16, split(origin, ","))
            x_de, y_de = parse.(UInt16, split(des, ","))
            x_or != x_de && y_or != y_de && continue
            y_or, x_de = sort([x_or, x_de])
            y_or, y_de = sort([x_or, y_de])
            diagram[x_or:x_de, y_or:y_de] .+= 1;
        end
        length(diagram[diagram .>= 2]) |> println
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
