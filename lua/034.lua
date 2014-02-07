-- 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
--
-- Find the sum of all numbers which are equal to the sum of the factorial of
-- their digits.
--
-- Note: as 1! = 1 and 2! = 2 are not sums they are not included.

FACS = {[0] = 1, [1] = 1}

function fac(n)
    if FACS[n] then
        return FACS[n]
    else
        local prod = n * fac(n-1)
        FACS[n] = prod
        return prod
    end
end


function is_dig_fac(n)
    local s = tostring(n)

    local sum = 0
    for i=1,#s do
        local dig = tonumber(string.sub(s,i,i))
        sum = sum + fac(dig)
    end

    return sum == n
end


function main()
    local sum = 0
    for i=10,100000 do
        if is_dig_fac(i) then
            sum = sum + i
        end
    end

    print(sum)
end

main()
