-- Starting with the number 1 and moving to the right in a clockwise direction a 5
-- by 5 spiral is formed as follows:
-- 
-- 21 22 23 24 25
-- 20  7  8  9 10
-- 19  6  1  2 11
-- 18  5  4  3 12
-- 17 16 15 14 13
-- 
-- It can be verified that the sum of the numbers on the diagonals is 101.
-- 
-- What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed
-- in the same way?


-- 1001x1001 is level 501

function get_sum_corners(level)
    if level == 1 then
        return 1
    else
        local n = 2*level - 1
        return 4 * (n*n - 1.5*(n-1))
    end
end


function get_sum_diags(level)
    if level <= 0 then return 0 end

    return get_sum_corners(level) + get_sum_diags(level-1)
end

function main()
    print(get_sum_diags(501))
end

main()
