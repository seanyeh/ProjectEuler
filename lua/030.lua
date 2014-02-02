-- Surprisingly there are only three numbers that can be written as the sum of
-- fourth powers of their digits:
--
--     1634 = 14 + 64 + 34 + 44
--     8208 = 84 + 24 + 04 + 84
--     9474 = 94 + 44 + 74 + 44
--
-- As 1 = 14 is not a sum it is not included.
--
-- The sum of these numbers is 1634 + 8208 + 9474 = 19316.
--
-- Find the sum of all the numbers that can be written as the sum of fifth powers
-- of their digits


function is_valid(num)
    local sum = 0
    local strnum = tostring(num)

    for i=1,#strnum do
        local dig = tonumber(string.sub(strnum, i, i))
        sum = sum + math.pow(dig, 5)
    end

    return sum == num
end

function main()
    local sum = 0
    for i=2,1000000 do -- should be enough :)
        if is_valid(i) then
            sum = sum + i
        end
    end

    print(sum)
end

main()
