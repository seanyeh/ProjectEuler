-- NOTE: This problem is a significantly more challenging version of Problem 81.
-- 
-- In the 5 by 5 matrix below, the minimal path sum from the top left to the
-- bottom right, by moving left, right, up, and down, is indicated in bold red and
-- is equal to 2297.
-- 
-- 	
-- 131	673	234	103	18
-- 201	96	342	965	150
-- 630	803	746	422	111
-- 537	699	497	121	956
-- 805	732	524	37	331
-- 	
-- 
-- Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target
-- As...'), a 31K text file containing a 80 by 80 matrix, from the top left to the
-- bottom right by moving left, right, up, and down.

-- See 081.lua
--

arg=nil
dofile("081.lua")

function getNeighbors(grid, row, col)
    local neighbors = {}

    -- down
    if grid[row+1] and grid[row+1][col] then
        neighbors[#neighbors+1] = grid[row+1][col]
    end
    -- up
    if grid[row-1] and grid[row-1][col] then
        neighbors[#neighbors+1] = grid[row-1][col]
    end
    -- right
    if grid[row][col+1] then
        neighbors[#neighbors+1] = grid[row][col+1]
    end
    -- left
    if grid[row][col-1] then
        neighbors[#neighbors+1] = grid[row][col-1]
    end

    return neighbors
end

main()
