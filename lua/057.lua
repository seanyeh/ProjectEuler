-- It is possible to show that the square root of two can be expressed as an
-- infinite continued fraction.
--
-- √ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
--
-- By expanding this for the first four iterations, we get:
--
-- 1 + 1/2 = 3/2 = 1.5
-- 1 + 1/(2 + 1/2) = 7/5 = 1.4
-- 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
-- 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
--
-- The next three expansions are 99/70, 239/169, and 577/408, but the eighth
-- expansion, 1393/985, is the first example where the number of digits in the
-- numerator exceeds the number of digits in the denominator.
--
-- In the first one-thousand expansions, how many fractions contain a numerator
-- with more digits than denominator?

local bc = require("bc")

function f(n)
    local num, den
    if n == 1 then
        num, den = 3, 2
    else
        local prev_num, prev_den = f(n-1)

        den = bc.add(prev_num, prev_den)
        num = bc.add(prev_den, den)
    end

    return num, den
end


function digs(n)
    return #tostring(n)
end


function main()
    local fracs = 0
    for i = 1, 1000 do
        local num, den = f(i)
        if digs(num) > digs(den) then
            fracs = fracs + 1
        end
    end
    print(fracs)
end

main()
