-- Starting in the top left corner of a 2×2 grid, and only being able to move to
-- the right and down, there are exactly 6 routes to the bottom right corner.
-- 
-- How many such routes are there through a 20×20 grid?


cache = {["0,0"]=1}

function toString(x,y)
    if x > y then x,y = y,x end
    
    return string.format("%d,%d",x,y)
end


function descend(x, y)
    if x < 0 or y < 0 then
        return 0
    end

    local s = toString(x,y)
    if cache[s] then
        return cache[s]
    elseif x < 0 or y < 0 then
        return 0
    else
        local result = descend(x-1, y) + descend(x, y-1)
        cache[s] = result
        return result
    end
end

print(descend(20,20))
