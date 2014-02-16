-- 5dig number 16807=7^5 is also a 5th power
-- 9dig number 134217728=8^9 is a 9th power
--
-- how many ndigit positive integers are also an nth power?

local bc = require("bc")

function digs(n)
    return #tostring(n)
end


function main()
    local nums = 0
    for i = 1, 9 do
        local pow = 1
        while digs(bc.pow(i,pow)) == pow do
            pow = pow + 1
            nums = nums + 1
        end
    end
    print(nums)
end

main()
