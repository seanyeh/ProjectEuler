-- Starting with 1 and spiralling anticlockwise in the following way, a square
-- spiral with side length 7 is formed.
--
-- 37 36 35 34 33 32 31
-- 38 17 16 15 14 13 30
-- 39 18  5  4  3 12 29
-- 40 19  6  1  2 11 28
-- 41 20  7  8  9 10 27
-- 42 21 22 23 24 25 26
-- 43 44 45 46 47 48 49
--
-- It is interesting to note that the odd squares lie along the bottom right
-- diagonal, but what is more interesting is that 8 out of the 13 numbers lying
-- along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.
--
-- If one complete new layer is wrapped around the spiral above, a square spiral
--     with side length 9 will be formed. If this process is continued, what is
--     the side length of the square spiral for which the ratio of primes along
--     both diagonals first falls below 10%?

-- Not quite the most optimal :(

-- return num_primes, num_corners
function get_corners(level)
    if level == 1 then
        return 0, 1
    else
        local side = 2*level - 1

        local se = side*side
        local sw = se - side + 1
        local nw = sw - side + 1
        local ne = nw - side + 1

        local num_primes = 0
        for _, v in pairs({se,sw,nw,ne}) do
            if is_prime(v) then
                num_primes = num_primes + 1
            end
        end
        return num_primes, 4
    end
end


function get_prime_ratio(level)
    if level <= 0 then return 0, 0 end

    local a, b = get_prime_ratio(level - 1)
    local cur_primes, cur_totals = get_corners(level)

    return a + cur_primes, b + cur_totals
end


function test_levels(start_level, inc)
    inc = inc or 1

    local level = start_level or 1
    local a, b = 0, 0

    while a == 0 or a/b >= 0.10 do
        level = level + inc
        a, b = get_prime_ratio(level)
        -- print("level:",level,a/b)
    end
    return level
end


function main()
    -- Sort of hacky way to divide and conquer
    local inc = 1000
    local start_level = test_levels(1, inc) - inc
    inc = 10
    start_level = test_levels(start_level, inc) - inc

    local level = test_levels(start_level, 1)
    print(2*level - 1)
end

main()
