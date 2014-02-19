-- It is possible to write five as a sum in exactly six different ways:
--
-- 4 + 1
-- 3 + 2
-- 3 + 1 + 1
-- 2 + 2 + 1
-- 2 + 1 + 1 + 1
-- 1 + 1 + 1 + 1 + 1
--
-- How many different ways can one hundred be written as a sum of at least two
-- positive integers?

local POSS = {}

function get_possibilities(n, start_i)
    start_i = start_i or n

    if start_i > n then start_i = n end

    local s = tostring(n)..","..tostring(start_i)
    if POSS[s] then return POSS[s] end

    if n <= 1 then
        return 1
    end

    local possibilities = 0
    for i = start_i, 1, -1 do
        possibilities = possibilities + get_possibilities(n-i,i)
    end

    POSS[s] = possibilities
    return possibilities
end


function main()
    -- -1 because we don't want to include just itself for the final answer
    print(get_possibilities(100) - 1)
end

main()
