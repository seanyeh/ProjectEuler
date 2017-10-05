-- A row measuring seven units in length has red blocks with a minimum length of
-- three units placed on it, such that any two red blocks (which are allowed to be
-- different lengths) are separated by at least one black square. There are
-- exactly seventeen ways of doing this.
--
-- How many ways can a row measuring fifty units in length be filled?
--
-- NOTE: Although the example above does not lend itself to the possibility, in
-- general it is permitted to mix block sizes. For example, on a row measuring
-- eight units in length you could use red (3), black (1), and red (4).


function get_combos(max_sum)
    local sums = {
        [0] = {0, 0},
        [1] = {1, 0},
        [2] = {1, 0},
        [3] = {1, 1} -- first element = number of items not ending in red,
                     -- second element = number of items ending in red
    }

    for i=4,max_sum do
        local new_sums = {sums[#sums][1] + sums[#sums][2], sums[#sums][2]}

        if sums[i-3] ~= nil then
            new_sums[2] = new_sums[2] + sums[i-3][1]
        end

        sums[#sums+1] = new_sums

    end

    print(sums[#sums][1] + sums[#sums][2])
end


function main()
    get_combos(50)
end

main()
