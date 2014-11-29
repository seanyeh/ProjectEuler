-- Peter has nine four-sided (pyramidal) dice, each with faces numbered 1, 2, 3,
-- 4.  Colin has six six-sided (cubic) dice, each with faces numbered 1, 2, 3, 4,
-- 5, 6.
--
-- Peter and Colin roll their dice and compare totals: the highest total wins. The
-- result is a draw if the totals are equal.
--
-- What is the probability that Pyramidal Pete beats Cubic Colin? Give your answer
-- rounded to seven decimal places in the form 0.abcdefg


function gen_dice_sums(num_dice, num_sides, i)
    i = i or 0

    if i >= num_dice then
        return {0}
    else
        local arr = {}

        local next_arr = gen_dice_sums(num_dice, num_sides, i+1)

        for i=1,num_sides do
            for _, v in pairs(next_arr) do

                arr[#arr + 1] = i + v
            end
        end

        return arr
    end
end


function group_vals(vals_raw)
    local cache = {}
    for _, v in pairs(vals_raw) do
        if not cache[v] then
            cache[v] = 1
        else
            cache[v] = cache[v] + 1
        end

    end

    return cache
end


function main()
    local peter_raw = gen_dice_sums(9,4)
    local colin = gen_dice_sums(6,6)

    -- Group the values for peter
    local peter = group_vals(peter_raw)

    local total = #peter_raw * #colin

    local peter_wins = 0
    for v_p, n_p in pairs(peter) do
        for _, v_c in pairs(colin) do
            if v_p > v_c then
                peter_wins = peter_wins + n_p
            end
        end
    end

    print(peter_wins/total)
end

main()
