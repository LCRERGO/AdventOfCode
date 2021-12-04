function move_sub(data)
    depth = 0
    x_pos = 0
    for datum in data
        if datum[1] == "forward"
            x_pos += parse(Int ,datum[2])
        elseif datum[1] == "up"
            depth -= parse(Int ,datum[2])
        else # datum[1] == "down"
            depth += parse(Int ,datum[2])
        end
    end
    (x_pos, depth)
end

function main()
    open(ARGS[1], "r") do f
        data = [Tuple(split(x)) for x in readlines(f)]
        x_pos,depth = move_sub(data)
        println(x_pos * depth)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
