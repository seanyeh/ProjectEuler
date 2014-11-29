-- Find the unique positive integer whose square has the form 1_2_3_4_5_6_7_8_9_0,
-- where each “_” is a single digit.

local bc = require("bc")

local DIGS = {
    bc.number(0),
    bc.number(9),
    bc.number(8),
    bc.number(7),
    bc.number(6),
    bc.number(5),
    bc.number(4),
    bc.number(3),
    bc.number(2),
    bc.number(1)
}

function is_valid(n)
    for _, v in ipairs(DIGS) do
        if bc.mod(n,10) ~= v then
            return false
        end

        n = bc.div(n, 100)
    end

    return true
end

function main()
    -- starting number, from trial and error
    local n = bc.number("1350101070")
    while true do
        if is_valid(bc.mul(n,n)) then
            print(n)
            return
        end
        n = bc.add(n, 100)
    end
end

main()
