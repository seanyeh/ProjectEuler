-- A unit fraction contains 1 in the numerator. The decimal representation of the
-- unit fractions with denominators 2 to 10 are given:
-- 
--     1/2	= 	0.5
--     1/3	= 	0.(3)
--     1/4	= 	0.25
--     1/5	= 	0.2
--     1/6	= 	0.1(6)
--     1/7	= 	0.(142857)
--     1/8	= 	0.125
--     1/9	= 	0.(1)
--     1/10	= 	0.1
-- 
-- Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be
-- seen that 1/7 has a 6-digit recurring cycle.
-- 
-- Find the value of d < 1000 for which 1/d contains the longest recurring cycle
-- in its decimal fraction part.
-- 

bc = require("bc")
bc.digits(3000)

-- start looking at 10 digits
function get_repeating_digits(den)
    local s = string.sub(bc.tostring(bc.div(1,den)),3)
    local i = 10

    local rep_len = 0
    while i < den do
        local s1 = string.sub(s,1, i)
        local s2 = string.sub(s,i + 1, i + i)
        if s1 == s2 then
            rep_len = i
            break
        end
         i = i + 1
    end
    return rep_len
end

-- function is_repeating(den,dbg)
--     local s = bc.tostring(bc.div(1,den))
-- 
--     local len = den - 1
--     local s1 = string.sub(s, 3, 3 + len -1)
--     local s2 = string.sub(s, 3 + len, 3 + 2 * len - 1)
-- 
--     if dbg then print(s1,s2) end
-- 
--     return s1 == s2
-- end

function main()
    local max, max_num = 0, 0
    for i = 500,1000 do
        local temp = get_repeating_digits(i)
        if temp > max then
            max, max_num = temp, i
        end
    end
    print(max_num)
end

main()
