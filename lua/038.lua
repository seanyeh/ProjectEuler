-- Take the number 192 and multiply it by each of 1, 2, and 3:
--
--     192 × 1 = 192
--     192 × 2 = 384
--     192 × 3 = 576
--
-- By concatenating each product we get the 1 to 9 pandigital, 192384576. We will
-- call 192384576 the concatenated product of 192 and (1,2,3)
--
-- The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and
-- 5, giving the pandigital, 918273645, which is the concatenated product of 9 and
-- (1,2,3,4,5).
--
-- What is the largest 1 to 9 pandigital 9-digit number that can be formed as the
-- concatenated product of an integer with (1,2, ... , n) where n > 1?


function is_pandigital(s)
    if #s ~= 9 then
        return false
    end

    local temp = {}
    for i=1,#s do
        local c = string.sub(s,i,i)
        if c == "0" or temp[c] then
            return false
        end

        temp[c] = 1
    end
    
    return true
end


function is_pandigital_mult(n)
    local s = tostring(n)
    local i = 1
    while #s < 9 do
        i = i + 1
        s = s..tostring(n*i)
    end

    return is_pandigital(s), s
end


function main()
    local maxs = ""
    for i = 1,100000 do
        local is_valid, s = is_pandigital_mult(i)
        if is_valid then
            maxs = s
        end
    end

    print(maxs)
end

main()
