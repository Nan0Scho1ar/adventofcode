include("../../libs/julia/n0s1-aoc.jl")

function count_deeper(data)
    lines = [parse(Int64, i) for i in split(data, "\n")]
    sum([1 for i in range(2,length(lines)) if (lines[i] - lines[i-1]) > 0])
end

println(count_deeper(readstring("sample-2021-01.txt")))
println(count_deeper(readstring("input-2021-01.txt")))
