-- The series, 11 + 22 + 33 + ... + 1010 = 10405071317.
--
-- Find the last ten digits of the series, 11 + 22 + 33 + ... + 10001000.

local bc = require("bc")

function main()
    local sum = 0
    for i = 1, 1000 do
        sum = bc.add(sum, bc.pow(i,i))
    end

    local s = tostring(sum)
    print(s:sub(#s-9,#s))
end

main()
