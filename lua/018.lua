-- By starting at the top of the triangle below and moving to adjacent numbers on
-- the row below, the maximum total from top to bottom is 23.
-- 
-- 3
-- 7 4
-- 2 4 6
-- 8 5 9 3
--
-- That is, 3 + 7 + 4 + 9 = 23.
-- 
-- Find the maximum total from top to bottom of the triangle below:
-- 
-- 75
-- 95 64
-- 17 47 82
-- 18 35 87 10
-- 20 04 82 47 65
-- 19 01 23 75 03 34
-- 88 02 77 73 07 63 67
-- 99 65 04 28 06 16 70 92
-- 41 41 26 56 83 40 80 70 33
-- 41 48 72 33 47 32 37 16 94 29
-- 53 71 44 65 25 43 91 52 97 51 14
-- 70 11 33 28 77 73 17 78 39 68 17 57
-- 91 71 52 38 17 14 91 43 58 50 27 29 48
-- 63 66 04 68 89 53 67 30 73 16 69 87 40 31
-- 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
-- 
-- NOTE: As there are only 16384 routes, it is possible to solve this problem by
-- trying every route. However, Problem 67, is the same challenge with a triangle
-- containing one-hundred rows; it cannot be solved by brute force, and requires a
-- clever method! ;o)


-- Yes, I realize using the A* algorithm is perhaps a little overkill for this
-- problem. Oh well :)
--
-- Also works with #67

function compareNode(a,b)
    if a.f < b.f then
        return -1
    elseif a.f > b.f then
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

local MAX_VALUE = 100
function Node:new(x,y, value)
    local newObj = {x=x, y=y, children={}, origValue=value, value=MAX_VALUE-value,f=nil,g=nil,h=nil}
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
        return node.origValue + sumPath(node.parent)
    end
end


function debugPath(node)
    local s = ""
    while node do
        s = tostring(node.origValue)..","..s
        node = node.parent
    end
    return s
end

function debugQueue(q)
    local s = ""
    print "----"
    for i=1,#(q.array) do
        print("f:",q.array[i].f,"origValue:", q.array[i].origValue,"path:",debugPath(q.array[i]))
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

        -- GOAL IS WHEN NO SUCCESSORS
        if #successors == 0 then
            print "Found goal!"
            local sum = sumPath(node)
            print("sum:",sum)
            print("path:", debugPath(node))
            return
        end

        for i, succ in ipairs(successors) do

            local temp_g = node.g + succ.value
            local temp_f = temp_g + succ.h
            -- print("succ:", succ.origValue, "with f=",temp_f, "path=",debugPath(succ))

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
        end
        closed_list[node:toStringPos()] = node
    end

end

--------------------------------------------

NUM_ROWS = 0

function heuristic(node)
    return NUM_ROWS - node.y -- number of steps away from bottom row
end
function isGoal(node)
    return node.y == NUM_ROWS
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

          n.h = heuristic(n)

          grid[row][col] = n
          col = col + 1
      end
  end
  -- update NUM_ROWS
  NUM_ROWS = #grid

  return grid
end


function preprocess_children(grid)
    for row=1,#grid-1 do -- don't do last row
        for col=1,#grid[row] do
            local n = grid[row][col]
            n.children = {grid[row+1][col],grid[row+1][col+1]}
        end
    end
end


function main()
    local filename = arg[1] or "018.txt"

    g = lines_from(filename)
    preprocess_children(g)
    local start_node = g[1][1]
    start_node.f, start_node.g = 0, 0
    a_star(g, start_node)
end

main()
