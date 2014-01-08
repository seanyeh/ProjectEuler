-- In the 5 by 5 matrix below, the minimal path sum from the top left to the
-- bottom right, by only moving to the right and down, is indicated in bold red
-- and is equal to 2427.
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
-- bottom right by only moving right and down.
-- 

-- A* search, adapted from 018.lua
-- Also used for #82 and #83

function compareNode(n1, n2, f)
    local a, b = n1.f, n2.f
    
    if a < b then
        return -1
    elseif a > b then
        return 1
    else
        return 0
    end
end

------------------------------------
-- Priority Queue (heap)

PQueue = {}

function PQueue:new()
    local newObj = {array={},size=0, compare=compareNode}
    self.__index = self
    return setmetatable(newObj, self) 
end

function PQueue:insert(obj)
    self.size = self.size + 1
    
    -- Percolate up
    local hole = self.size

    while hole > 1 and self.compare(obj,self.array[math.floor(hole/2)]) < 0 do
        self.array[hole] = self.array[math.floor(hole/2)]
        hole = math.floor(hole/2)
    end
    self.array[hole] = obj
end

function PQueue:deleteMin()
    if self.size == 0 then
        print "Is empty already!"
        return nil
    end

    local min = self.array[1]
    self.array[1] = self.array[self.size]
    self.size = self.size - 1

    self:_percolateDown(1)

    return min
end

function PQueue:_percolateDown(hole)
    local temp = self.array[hole]

    -- while hole is not a leaf
    while hole * 2 <= self.size do
        -- assume left child
        local child = hole * 2
        -- if right child is less than left, use that
        if (child ~= self.size and self.compare(self.array[child+1], self.array[child]) < 0) then
            child = child + 1
        end

        -- Swap with child
        if self.compare(self.array[child], temp) < 0 then
            self.array[hole] = self.array[child]
        else
            break
        end

        hole = child
    end

    self.array[hole] = temp
end

function PQueue:getIndex(obj)
    for i=1,#(self.array) do
        if self.array[i]:equal(obj) then
            return i
        end
    end
    return -1
end

function PQueue:get(index)
    return self.array[index]
end

function PQueue:remove(index)
    if index > self.size then
        print("Index does not exist!")
        return
    end

    local removed = self.array[index]
    self.array[index] = self.array[self.size]
    self.size = self.size - 1

    self:_percolateDown(index)

    return removed
end


function PQueue:display()
    local i = 1

    while i <= self.size do
        -- print newline for each level
        local temp = math.log(i)/math.log(2)
        if math.floor(temp) == temp then
            io.write("\n")
        end

        local s
        if self.array[i].toString then
            s = self.array[i]:toString()
        else
            s=tostring(self.array[i])
        end

        io.write(s..",")

        i = i + 1
    end
    io.write("\n")
end

------------------------------------
-- Node

Node = {}

-- local MAX_VALUE = 100
function Node:new(x,y, value)
    local newObj = {x=x, y=y, children={}, value=value, f=nil,g=nil,h=nil}
    self.__index = self
    return setmetatable(newObj, self) 
end

function Node:equal(otherNode)
    return self.x == otherNode.x and self.y == otherNode.y
end

function Node:toStringPos()
    return string.format("%d,%d", self.x, self.y)
end

function Node:toString()
    return tostring(self.value)
end

------------------------------------

-- also show path
function sumPath(node)
    if not node then
        return 0
    else
        return node.value + sumPath(node.parent)
    end
end


function debugPath(node)
    local s = ""
    while node do
        s = tostring(node.value)..","..s
        node = node.parent
    end
    return s
end

function debugQueue(q)
    local s = ""
    print "----"
    for i=1,#(q.array) do
        print("f:",q.array[i].f,"value:", q.array[i].value,"path:",debugPath(q.array[i]))
    end
    print "----"
end

function a_star(queue, start_node)
    open_list = PQueue:new()
    open_list:insert(start_node)
    -- Closed list is indexed by the string representation of their position
    closed_list = {}

    while open_list.size > 0 do
        -- debugQueue(open_list)

        local node = open_list:deleteMin()

        local successors = node.children

        for i, succ in ipairs(successors) do

            if isGoal(succ) then
                succ.parent = node
                print "Found goal!"
                local sum = sumPath(succ)
                print("sum:",sum)
                print("path:", debugPath(succ))
                return
            end

            local temp_g = node.g + succ.value
            local temp_f = temp_g + succ.h
            -- print("succ:", succ.value, "with f=",temp_f, "path=",debugPath(succ))

            local temp_c = closed_list[succ:toStringPos()]
            local open_index = open_list:getIndex(succ)
            local temp_o = open_list:get(open_index)


            if temp_c and temp_c.f <= temp_f then
                -- print("already exists in closed")

                -- If already exists in closed and f is already better
                -- skip, do nothing
            elseif temp_o and temp_o.f <= temp_f then
                -- print("already exists in closed")

                -- If already exists in open and f is already better
                -- skip, do nothing
            else
                -- delete if a suboptimal version of succ is there
                if (open_index > 0) then 
                    -- print("replace suboptimal in open")
                    open_list:remove(open_index) 
                end

                -- print("insert into open")

                -- set vars here:
                succ.f, succ.g = temp_f, temp_g
                succ.parent = node
                
                -- insert succ to open_list
                open_list:insert(succ)
            end

        end -- end for

        closed_list[node:toStringPos()] = node
    end

end

--------------------------------------------

NUM_ROWS = 0

-- yes i know, not a very good heuristic
function heuristic(node, method)
    method = method or ""

    local min_steps = (NUM_ROWS - node.y) + (NUM_ROWS - node.x)

    -- Better method
    if method == "better" then
        local sum = 0
        for i=1,min_steps do
            sum = sum + SORTED_NUMS[i]
        end
        return sum
    end

    -- naive heuristic
    return min_steps
end
function isGoal(node)
    return node.y == NUM_ROWS and node.x == NUM_ROWS
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  grid = {}
  for line in io.lines(file) do 
      local row = #grid+1
      grid[row] = {}
      
      local col = 1
      for i in string.gmatch(line, "%S+") do
          local num = tonumber(i)

          -- Create node: x, y, value
          local n = Node:new(col, row, num)


          grid[row][col] = n
          col = col + 1
      end
  end
  -- update NUM_ROWS
  NUM_ROWS = #grid

  return grid
end


function getNeighbors(grid, row, col)
    local neighbors = {}

    if grid[row+1] and grid[row+1][col] then
        neighbors[#neighbors+1] = grid[row+1][col]
    end

    if grid[row][col+1] then
        neighbors[#neighbors+1] = grid[row][col+1]
    end

    return neighbors
end

-- for better heuristic
SORTED_NUMS = {}

function getSorted(grid)
    local sorted = {}
    for row=1, #grid do
        for col=1, #grid[row] do
            sorted[#sorted+1] = grid[row][col].value
        end
    end

    table.sort(sorted)
    return sorted
end



-- preprocess children and heuristic values
function preprocess(grid)
    SORTED_NUMS = getSorted(grid)
    
    for row=1,#grid do
        for col=1,#grid[row] do
            local n = grid[row][col]

            --heuristic
            n.h = heuristic(n,"better")
            
            --children
            n.children = getNeighbors(grid, row, col)
        end
    end
end



function main(filename)
    filename = filename or "081.txt"

    g = lines_from(filename)
    preprocess(g)
    local start_node = g[1][1]
    start_node.f, start_node.g = start_node.value, 0
    a_star(g, start_node)
end

if arg then main(arg[1]) end
