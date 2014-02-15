-- A googol (10^100) is a massive number: one followed by one-hundred zeros; 100^100
-- is almost unimaginably large: one followed by two-hundred zeros. Despite their
-- size, the sum of the digits in each number is only 1.
--
-- Considering natural numbers of the form, a^b, where a, b < 100, what is the
-- maximum digital sum?

local bc = require("bc")

function get_digit_sum(n)
    local s = tostring(n)
    local sum = 0
    for i = 1, #s do
        sum = sum + tonumber(s:sub(i,i))
    end
    return sum
end


function main()
    local maxsum = 0
    for a = 1, 99 do
        for b = 1, 99 do
            local sum = get_digit_sum(bc.pow(a,b))
            if sum > maxsum then
                maxsum = sum
            end
        end
    end
    print(maxsum)
end

main()
