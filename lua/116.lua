-- A row of five black square tiles is to have a number of its tiles replaced with
-- coloured oblong tiles chosen from red (length two), green (length three), or
-- blue (length four).
--
-- If red tiles are chosen there are exactly seven ways this can be done.
--
-- If green tiles are chosen there are three ways.
--
-- And if blue tiles are chosen there are two ways.
--
-- Assuming that colours cannot be mixed there are 7 + 3 + 2 = 12 ways of
-- replacing the black tiles in a row measuring five units in length.
--
-- How many different ways can the black tiles in a row measuring fifty units in
-- length be replaced if colours cannot be mixed and at least one coloured tile
-- must be used?
--
-- NOTE: This is related to Problem 117.


function get_combos(m, n)
    local sums = {
        [0] = 1,
    }

    for i=1,m-1 do
        sums[i] = 1
    end
    sums[m] = 2

    for i=m+1,n do
        local new_sum = sums[#sums]

        if sums[i-m] ~= nil then
            new_sum = new_sum + sums[i-m]
        end

        sums[#sums+1] = new_sum

    end

    return sums[#sums] - 1 -- Subtract one to remove "all black"
end


function main()
    print(get_combos(2,50) + get_combos(3, 50) + get_combos(4,50))
end

main()
