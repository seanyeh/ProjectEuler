-- NOTE: This problem is a more challenging version of Problem 81.
-- 
-- The minimal path sum in the 5 by 5 matrix below, by starting in any cell in the
-- left column and finishing in any cell in the right column, and only moving up,
-- down, and right, is indicated in red and bold; the sum is equal to 994.
-- 
-- 131	673	234	103	18
-- 201	96	342	965	150
-- 630	803	746	422	111
-- 537	699	497	121	956
-- 805	732	524	37	331
-- 
-- Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target
-- As...'), a 31K text file containing a 80 by 80 matrix, from the left column to
-- the right column.
--

-- See 081.lua

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

    return neighbors
end

function isGoal(node)
    -- hack: pseudo end node has x = NUM_ROWS + 1
    return node.x == NUM_ROWS + 1
end

function main(filename)
    filename = filename or "081.txt"

    g = lines_from(filename)
    preprocess(g)

    -- create pseudo start node with all left-side cells as its children
    local start_node = Node:new(0,0,0)
    local children = start_node.children

    for i = 1,#grid do
        children[i] = grid[i][1]
    end

    -- create pseudo goal node as a child of all right-side cells
    local END_NODE = Node:new(NUM_ROWS + 1,0,0)
    for i = 1,#grid do
        local len = #grid[i]
        local children = grid[i][len].children
        children[#children+1] = END_NODE
    end
        


    start_node.f, start_node.g = 0, 0
    a_star(g, start_node)
end

main()

