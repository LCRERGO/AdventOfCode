function move_sub(data)
    depth, x_pos, aim = 0, 0, 0

    for datum in data
        argument = parse(Int ,datum[2])
        if datum[1] == "forward"
            x_pos += argument
            depth += aim*argument 
        elseif datum[1] == "up"
            aim -= argument
        else # datum[1] == "down"
            aim += argument
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
