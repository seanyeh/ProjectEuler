-- By counting carefully it can be seen that a rectangular grid measuring 3 by 2
-- contains eighteen rectangles:
--
-- Although there exists no rectangular grid that contains exactly two million
-- rectangles, find the area of the grid with the nearest solution.

-- aka summation formula
function all_combinations(n)
    return n*(n+1)/2
end


function num_rects(a, b)
    return all_combinations(a) * all_combinations(b)
end


function main()
    local TWOMIL = 2000000
    -- find max b such that 1 x b is just above 2000000
    local max_b = 1
    while num_rects(1, max_b) < TWOMIL do
        max_b = max_b + 1
    end

    local min_diff, min_area = num_rects(1, max_b) - TWOMIL, 0
    for a = 1, max_b/2 do
        for b = max_b, 1, -1 do
            local temp_diff = num_rects(a, b) - TWOMIL

            if math.abs(temp_diff) < min_diff then
                min_diff, min_area = math.abs(temp_diff), a * b
            end

            if temp_diff < 0 then
                break
            else
                max_b = b
            end

        end
    end

    print(min_area)
end

main()
