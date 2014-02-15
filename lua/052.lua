-- It can be seen that the number, 125874, and its double, 251748, contain exactly
-- the same digits, but in a different order.
--
-- Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x,
-- contain the same digits.

function get_digs(n)
    local digs = {}
    while n > 0 do
        digs[#digs+1] = n%10
        n = math.floor(n/10)
    end

    return digs
end


function same_digs(n1, n2)
    local d1, d2 = get_digs(n1), get_digs(n2)

    if #d1 ~= #d2 then return false end

    table.sort(d1)
    table.sort(d2)
    return table.concat(d1) == table.concat(d2)
end


function is_valid(n)
    for i = 2, 6 do
        if not same_digs(n, i*n) then
            return false
        end
    end
    return true
end


function main()
    local start = 100000
    for i = start,start*10 do
        if is_valid(i) then
            print(i)
            return
        end
    end
end

main()
