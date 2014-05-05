-- Su Doku (Japanese meaning number place) is the name given to a popular puzzle
-- concept. Its origin is unclear, but credit must be attributed to Leonhard Euler
-- who invented a similar, and much more difficult, puzzle idea called Latin
-- Squares. The objective of Su Doku puzzles, however, is to replace the blanks
-- (or zeros) in a 9 by 9 grid in such that each row, column, and 3 by 3 box
-- contains each of the digits 1 to 9. Below is an example of a typical starting
-- puzzle grid and its solution grid.
--
-- A well constructed Su Doku puzzle has a unique solution and can be solved by
-- logic, although it may be necessary to employ "guess and test" methods in order
-- to eliminate options (there is much contested opinion over this). The
-- complexity of the search determines the difficulty of the puzzle; the example
-- above is considered easy because it can be solved by straight forward direct
-- deduction.
--
-- The 6K text file, sudoku.txt (right click and 'Save Link/Target As...'),
-- contains fifty different Su Doku puzzles ranging in difficulty, but all with
-- unique solutions (the first puzzle in the file is the example above).
--
-- By solving all fifty puzzles find the sum of the 3-digit numbers found in the
-- top left corner of each solution grid; for example, 483 is the 3-digit number
-- found in the top left corner of the solution grid above.


-- Just a simple brute force recursive solution without any optimizations

Box = {}

function Box:new(possibleVals)
    local newObj = {possibleVals=possibleVals, compare=compareNode, value=0}
    self.__index = self

    local obj = setmetatable(newObj, self) 
    obj:reset()
    return obj
end

function Box:get_possible_vals()
    return self.possibleVals
end

function Box:set_val(v)
    self.value = v
end

function Box:get_val()
    return self.value
end

function Box:reset()
    if #self.possibleVals == 1 then
        self.value = self.possibleVals[1]
    else
        self.value = 0
    end
end


function load_puzzles(filename)
    local grids = {}
    for l in io.lines(filename) do
        if l:sub(1,1) == "G" then
            grids[#grids + 1] = {}
        else
            local g = grids[#grids]

            for i = 1, #l do
                local v = tonumber(l:sub(i,i))
                local vals = {1,2,3,4,5,6,7,8,9}
                if v ~= 0 then
                    vals = {v}
                end

                g[#g + 1] = Box:new(vals)
            end
        end
    end
    return grids
end


function is_valid(grid)
    -- Check rows/cols
    for i = 0, 8 do
        local rtemp = {}
        local ctemp = {}
        for j = 0, 8 do
            -- check row
            local rval = grid[9*i + j + 1].value

            if rval ~= 0 and rtemp[rval] then 
                return false
            end
            rtemp[rval] = 1

            -- check col
            local cval = grid[9*j + i + 1].value
            if cval ~= 0 and ctemp[cval] then 
                return false
            end
            ctemp[cval] = 1
        end
    end

    -- Check 3x3 boxes
    local offsets = {1,2,3,10,11,12,19,20,21}
    for i = 0, 6, 3 do -- col
        for j = 0, 54, 27 do -- row
            local base_i = j + i
            local temp = {}
            for k = 1, #offsets do
                local val = grid[base_i + offsets[k]].value

                if val ~= 0 and temp[val] then 
                    return false
                end
                temp[val] = 1
            end
        end
    end

    return true
end


-- Debugging
function print_grid(grid)
    for i = 1, 81 do
        if i%9 == 1 then
            io.write("\n")
        end
        io.write(grid[i].value)
    end
    io.write("\n")
end


function solve(grid, i)
    if not is_valid(grid) then
        return false
    end

    if i > 81 then
        -- Solved!
        return grid
    end

    local current = grid[i]
    local possibleVals = current:get_possible_vals()

    for _,v in pairs(possibleVals) do
        current:set_val(v)

        local result = solve(grid, i + 1)
        if result then
            return result
        end
    end

    current:reset()
    return false
end


function get_3digit_num(grid)
    return 100*grid[1].value + 10*grid[2].value + grid[3].value
end


function main()
    local puzzles = load_puzzles("096.txt")

    local sum = 0
    for i = 1, #puzzles do
        local result = solve(puzzles[i], 1)
        sum = sum + get_3digit_num(result)
    end

    print(sum)
end


main()
