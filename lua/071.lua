-- Consider the fraction, n/d, where n and d are positive integers. If n<d and
-- HCF(n,d)=1, it is called a reduced proper fraction.
--
-- If we list the set of reduced proper fractions for d ≤ 8 in ascending order of
--     size, we get:
--
-- 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7,
-- 3/4, 4/5, 5/6, 6/7, 7/8
--
-- It can be seen that 2/5 is the fraction immediately to the left of 3/7.
--
-- By listing the set of reduced proper fractions for d ≤ 1,000,000 in ascending
-- order of size, find the numerator of the fraction immediately to the left of
-- 3/7.
--

local F = 3/7

function get_min_diff(d)
    local fracs = {}

    local min_diff = 1
    local min_num = 0

    for i = 2, d do
        local num, den = math.floor(F*i), i
        local diff = F - num/den

        if diff < min_diff and diff ~= 0 then
            min_diff = diff
            min_num, min_den = num, den
        end
    end

    return min_num
end


function main()
    print(get_min_diff(1000000))
end

main()
