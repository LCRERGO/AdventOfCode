
function main()
    MAX = 1000;
    open(ARGS[1], "r") do f
        diagram = zeros(UInt8, MAX, MAX)
        for line ∈ readlines(f)
            origin, des = split(line, "->")
            x_or, y_or = parse.(UInt16, split(origin, ",")) .|> x -> x + 1
            x_de, y_de = parse.(UInt16, split(des, ",")) .|> x -> x + 1
            if x_or == x_de || y_or == y_de
                x_or, x_de = sort([x_or, x_de]); y_or, y_de = sort([y_or, y_de])
                diagram[x_or:x_de, y_or:y_de] .+= 1;
            elseif (y_de - y_or) / (x_de - x_or) == 1
                x_min = sort([x_or, x_de])[1]; y_min = sort([y_or, y_de])[1]
                [diagram[x_min + i, y_min + i] += 1 for i ∈ 0:abs(x_or - x_de)]
            elseif (y_de - y_or) / (x_de - x_or) == -1
                x_min = sort([x_or, x_de])[1]; y_max = sort([y_or, y_de])[2]
                [diagram[x_min + i, y_max - i] += 1 for i ∈ 0:abs(x_or - x_de)]
            end
        end
        length(diagram[diagram .>= 2]) |> println
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
