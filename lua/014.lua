-- The following iterative sequence is defined for the set of positive integers:
-- 
-- n → n/2 (n is even) n → 3n + 1 (n is odd)
-- 
-- Using the rule above and starting with 13, we generate the following sequence:
-- 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
-- 
-- It can be seen that this sequence (starting at 13 and finishing at 1) contains
-- 10 terms. Although it has not been proved yet (Collatz Problem), it is thought
-- that all starting numbers finish at 1.
-- 
-- Which starting number, under one million, produces the longest chain?
-- 
-- NOTE: Once the chain starts the terms are allowed to go above one million.
-- 


lengths = {[1]=1}


function next_num(n)
    if n%2 == 0 then
        return n/2
    else
        return 3*n + 1
    end
end


function get_length(n)
    if lengths[n] then
        return lengths[n]
    else
        local len = get_length(next_num(n)) + 1
        lengths[n] = len
        return len
    end
end

function main()
    local max_len, max_num = 0, 0
    for i=1,999999 do
        local len = get_length(i)
        if len > max_len then
            max_len = len
            max_num = i
        end
    end

    print(max_num, "with len:", max_len)
end

main()
