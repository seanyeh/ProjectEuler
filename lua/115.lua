-- NOTE: This is a more difficult version of Problem 114.
--
-- A row measuring n units in length has red blocks with a minimum length of m
-- units placed on it, such that any two red blocks (which are allowed to be
-- different lengths) are separated by at least one black square.
--
-- Let the fill-count function, F(m, n), represent the number of ways that a row
-- can be filled.
--
-- For example, F(3, 29) = 673135 and F(3, 30) = 1089155.
--
-- That is, for m = 3, it can be seen that n = 30 is the smallest value for which
-- the fill-count function first exceeds one million.
--
-- In the same way, for m = 10, it can be verified that F(10, 56) = 880711 and
-- F(10, 57) = 1148904, so n = 57 is the least value for which the fill-count
-- function first exceeds one million.
--
-- For m = 50, find the least value of n for which the fill-count function first
--     exceeds one million.


function get_combos(m, n)
    local sums = {
        [0] = {0, 0},
    }

    for i=1,m-1 do
        sums[i] = {1,0}
    end
    sums[m] = {1,1}

    for i=m+1,n do
        local new_sums = {sums[#sums][1] + sums[#sums][2], sums[#sums][2]}

        if sums[i-m] ~= nil then
            new_sums[2] = new_sums[2] + sums[i-m][1]
        end

        sums[#sums+1] = new_sums

    end

    return sums[#sums][1] + sums[#sums][2]
end


function main()
    local n = 1

    while get_combos(50, n) < 1000000 do
        n = n + 1
    end

    print(n)
end

main()
