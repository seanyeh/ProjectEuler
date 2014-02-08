-- The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
--
-- Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:
--
--     d2d3d4=406 is divisible by 2
--     d3d4d5=063 is divisible by 3
--     d4d5d6=635 is divisible by 5
--     d5d6d7=357 is divisible by 7
--     d6d7d8=572 is divisible by 11
--     d7d8d9=728 is divisible by 13
--     d8d9d10=289 is divisible by 17
--
-- Find the sum of all 0 to 9 pandigital numbers with this property.


function tcopy(t)
    local t2 = {}
    for k,v in pairs(t) do
        t2[k] = v
    end
    return t2
end


-- Not as efficient as I could be. I should try generators/coroutines sometime
function gen_permutations(possible, level)
    level = level or 1

    if #possible <= 1 then
        return {possible[1]};
    end

    local results = {}
    for i=1,#possible do
        local current = possible[i];

        -- HACK: pruning for some rules
        if level == 1 and current == 0 then goto continue end -- cant begin with 0
        if level == 4 and current % 2 ~= 0 then goto continue end
        if level == 6 and current % 5 ~= 0 then goto continue end
        --

        local new_possible = tcopy(possible)
        table.remove(new_possible, i)
        
        local suffixes = gen_permutations(new_possible, level + 1);
        for j=1,#suffixes do
            local temp = current..suffixes[j]
            results[#results+1] = temp
        end

        ::continue::
    end
    return results;
end


function substr(s,i1, i2)
    return tonumber(s:sub(i1,i2))
end


function passes(n)
    local s = tostring(n)

    if #s ~= 10 then return false end

    -- if substr(s,2,4) % 2 ~= 0 then return false end
    if substr(s,3,5) % 3 ~= 0 then return false end
    -- if substr(s,4,6) % 5 ~= 0 then return false end
    if substr(s,5,7) % 7 ~= 0 then return false end
    if substr(s,6,8) % 11 ~= 0 then return false end
    if substr(s,7,9) % 13 ~= 0 then return false end
    if substr(s,8,10) % 17 ~= 0 then return false end

    return true
end


function main()
    local sum = 0
    for _, v in pairs(gen_permutations({0,1,2,3,4,5,6,7,8,9})) do
        local n = tonumber(v)
        if passes(n) then
            sum = sum + n
        end
    end

    print(sum)
end

main()
