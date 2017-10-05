-- Looking at the table below, it is easy to verify that the maximum possible sum
-- of adjacent numbers in any direction (horizontal, vertical, diagonal or
-- anti-diagonal) is 16 (= 8 + 7 + 1).  −2	5	3	2 9	−6	5	1 3	2	7	3 −1
-- 8	−4	  8
--
-- Now, let us repeat the search, but on a much larger scale:
--
-- First, generate four million pseudo-random numbers using a specific form of
-- what is known as a "Lagged Fibonacci Generator":
--
-- For 1 ≤ k ≤ 55, sk = [100003 − 200003k + 300007k^3] (modulo 1000000) − 500000.
--     For 56 ≤ k ≤ 4000000, sk = [sk−24 + sk−55 + 1000000] (modulo 1000000) −
--         500000.
--
-- Thus, s10 = −393027 and s100 = 86613.
--
-- The terms of s are then arranged in a 2000×2000 table, using the first 2000
-- numbers to fill the first row (sequentially), the next 2000 numbers to fill the
-- second row, and so on.
--
-- Finally, find the greatest sum of (any number of) adjacent entries in any
-- direction (horizontal, vertical, diagonal or anti-diagonal).

local SIZE = 2000

local SAMPLE_GRID = {
    -2,5,3,2,
    9,-6,5,1,
    3,2,7,3,
    -1,8,-4,8
}

function gen_grid()
    local grid = {}

    for i=1,2000*2000 do
        if i <= 55 then
            grid[#grid+1] = (100003 - 200003*i + 300007*(i^3))%1000000 - 500000
        else
            grid[#grid+1] = (grid[i-24] + grid[i-55])%1000000 - 500000
        end
    end

    return grid
end

-- row, col are 0-indexed
function get(grid, row, col)
    return grid[SIZE*row + col + 1]
end

function get_arrays(grid)
    local arrs = {}

    -- horiz/vert
    for r=0,SIZE-1 do
        local temp1 = {}
        local temp2 = {}
        for c=0,SIZE-1 do
            temp1[#temp1+1] = get(grid, r, c)
            temp2[#temp2+1] = get(grid, c, r)
        end
        arrs[#arrs+1] = temp1
        arrs[#arrs+1] = temp2
    end

    -- diag
    for c=-SIZE+1,SIZE-1 do
        local temp1 = {}
        local temp2 = {}
        for r=0,SIZE-1 do
            if (c+r) >= 0 and (c+r) < SIZE then
                temp1[#temp1+1] = get(grid, r, c+r)
                temp2[#temp2+1] = get(grid, SIZE-r-1, c+r)
            end
        end
        arrs[#arrs+1]=temp1
        arrs[#arrs+1]=temp2
    end

    return arrs
end


function max(a, b)
    if a > b then
        return a
    else
        return b
    end
end

function max_subarray(a)
    local max_so_far = a[1]
    local max_here = a[1]

    for i=2,#a do
        max_here = max(a[i], max_here + a[i])
        max_so_far = max(max_so_far, max_here)
    end

    return max_so_far
end

function main()
    -- local grid = SAMPLE_GRID
    local grid = gen_grid()
    local arrs = get_arrays(grid)

    local max_val = max_subarray(arrs[1])
    for _,a in pairs(arrs) do
        max_val = max(max_val, max_subarray(a))
    end

    print(max_val)
end

main()
