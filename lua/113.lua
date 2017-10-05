-- Working from left-to-right if no digit is exceeded by the digit to its left it
-- is called an increasing number; for example, 134468.
--
-- Similarly if no digit is exceeded by the digit to its right it is called a
-- decreasing number; for example, 66420.
--
-- We shall call a positive integer that is neither increasing nor decreasing a
-- "bouncy" number; for example, 155349.
--
-- As n increases, the proportion of bouncy numbers below n increases such that
-- there are only 12951 numbers below one-million that are not bouncy and only
-- 277032 non-bouncy numbers below 10^10.
--
-- How many numbers below a googol (10^100) are not bouncy?


function init_arr()
    a = {}
    for i=0,9 do
        a[i] = 0
    end
    return a
end


function get_next_nbs(digs_hash, is_decreasing)
    new_digs_hash = init_arr()
    for i, sum in pairs(digs_hash) do
        local a,b
        if is_decreasing then
            a,b = 0,i
        else
            a,b = i,9
        end

        for j=a,b do
            if sum > 0 then
                new_digs_hash[j] = new_digs_hash[j] + sum
            end
        end
    end

    return new_digs_hash
end


-- function debug_print(t)
--     for k,v in pairs(t) do
--         print(k, v)
--     end
-- end


function sum_digs(t)
    local sum = 0
    for _, n in pairs(t) do
        sum = sum + n
    end
    return sum
end


function get_nbs_sum(digs)
    local start_digs = {
        [0] = 0,
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 1,
        [5] = 1,
        [6] = 1,
        [7] = 1,
        [8] = 1,
        [9] = 1
    }

    local sum = 9
    local inc_digs = {table.unpack(start_digs)}
    local dec_digs = {table.unpack(start_digs)}

    for i=1,digs-1 do
        inc_digs = get_next_nbs(inc_digs, true)
        dec_digs = get_next_nbs(dec_digs, false)

        -- subtract 9 because we're double counting repeated numbers (e.g. 1111,2222)
        sum = sum + sum_digs(inc_digs) + sum_digs(dec_digs) - 9

    end
    -- debug_print(start_digs)

    print(sum)
end


function main()
    print(get_nbs_sum(100))
end

main()
