-- We shall say that an n-digit number is pandigital if it makes use of all the
-- digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1
-- through 5 pandigital.
--
-- The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing
-- multiplicand, multiplier, and product is 1 through 9 pandigital.
--
-- Find the sum of all products whose multiplicand/multiplier/product identity can
-- be written as a 1 through 9 pandigital.  HINT: Some products can be obtained in
-- more than one way so be sure to only include it once in your sum.


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


function main()
    local max = 10000
    local results = {}
    for a=1,max do
        for b=a,max do
            local prod = a * b
            local s = tostring(a)..tostring(b)..tostring(prod)
            if #s > 9 then
                break
            end

            if is_pandigital(s) then
                results[prod] = 1
            end
        end
    end
    
    local sum = 0
    for k, _ in pairs(results) do
        sum = sum + k
    end

    print("sum:", sum)
end

main()
