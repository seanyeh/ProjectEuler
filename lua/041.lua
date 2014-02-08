-- We shall say that an n-digit number is pandigital if it makes use of all the
-- digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is
-- also prime.
--
-- What is the largest n-digit pandigital prime that exists?


function is_prime(n)
    -- special cases: 2 is prime, 1 is not
    if n == 1 then return false end
    if n == 2 then return true end
    -- even: false
    if n%2 == 0 then return false end

    -- else:
    local max = math.floor(math.sqrt(n))
    for i=3,max,2 do
        if n%i == 0 then
            return false
        end
    end
    return true
end


function tcopy(t)
    local t2 = {}
    for k,v in pairs(t) do
        t2[k] = v
    end
    return t2
end


function tjoin(t1, t2)
    for _,v in pairs(t2) do
        t1[#t1+1] = v
    end
    return t1
end


-- Not as efficient as I could be. I should try generators/coroutines sometime
function gen_permutations(possible)
    if #possible <= 1 then
        return {possible};
    end

    local results = {}
    for i=1,#possible do
        local current = possible[i];

        local new_possible = tcopy(possible)
        table.remove(new_possible, i)
        
        local suffixes = gen_permutations(new_possible);
        for j=1,#suffixes do
            local temp = tjoin({current}, suffixes[j])
            results[#results+1] = temp
        end
    end
    return results;
end


function gen_poss(n)
    local t = {}
    for i=1,n do t[i] = i end
    return t
end


function get_max_prime(n)
    local max = -1
    local possible = gen_poss(n)
    for _, v in pairs(gen_permutations(possible)) do
        local n = tonumber(table.concat(v))
        if is_prime(n) and n > max then
            max = n
        end
    end
    return max
end


function main()
    local max = 0
    for i=1,9 do
        local n = get_max_prime(i)
        if n > max then
            max = n
        end
    end

    print(max)
end

main()
