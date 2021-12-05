function calcsum(index, num)
    final_board = boards[:, :, index[3]]
    num * sum(final_board[final_board .!= -1]) |> println
end

function main()
    open(ARGS[1], "r") do f
        nums = readline(f) |> x -> split(x, ",") |> x -> parse.(Int, x)

        global boards = read(f, String) |> x -> replace(x, "\n" => " ") |> x -> split(x, " ", keepempty=false)
        global boards = reshape(parse.(Int, boards), 5, 5, :)
        [boards[boards .== x] .= -1 for x in nums[1:4]]

        for num ∈ nums[5:end]
            global boards[boards .== num] .= -1
            horsum = sum(boards, dims=2) .== -5
            any(horsum) && (calcsum(findfirst(x -> x, horsum), num); break)
            versum = sum(boards, dims=1) .== -5
            any(versum) && (calcsum(findfirst(x -> x, versum), num); break)
        end
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
