-- The cube, 41063625 (345^3), can be permuted to produce two other cubes: 56623104
-- (384^3) and 66430125 (405^3). In fact, 41063625 is the smallest cube which has
-- exactly three permutations of its digits which are also cube.
--
-- Find the smallest cube for which exactly five permutations of its digits are
-- cube.

NUM_CUBES = {}

function get_digs(n)
    local digs = {}
    while n > 0 do
        digs[#digs+1] = n%10
        n = math.floor(n/10)
    end
    table.sort(digs)
    return digs
end


function main()
    -- generate cubes
    for i = 100, 10000 do
        local c = math.pow(i,3)
        local s = table.concat(get_digs(c))
        NUM_CUBES[s] = NUM_CUBES[s] or {}
        NUM_CUBES[s][#NUM_CUBES[s]+1] = c

        if (#NUM_CUBES[s] == 5) then
            print(NUM_CUBES[s][1])
            break
        end
    end
end

main()
