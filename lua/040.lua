-- An irrational decimal fraction is created by concatenating the positive
-- integers:
--
-- 0.123456789101112131415161718192021...
--
-- It can be seen that the 12th digit of the fractional part is 1.
--
-- If dn represents the nth digit of the fractional part, find the value of the
--     following expression.
--
-- d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000


function num_digs(power)
    if power == 0 then 
        return 1
    else
        local prevdigs = num_digs(power - 1)
        return prevdigs + power*(math.pow(10, power) - math.pow(10, power-1))
    end
end


function get_num(power, nth, numoffset)
    local base = "1"
    for i = 1,power-1 do
        base = base.."0"
    end

    local num = tonumber(base) + nth
    local dig = string.sub(tostring(num), numoffset+1, numoffset+1)
    return tonumber(dig)
end


function d(n)
    -- find max power
    local p = 0
    while num_digs(p) <= n do
        p = p + 1
    end

    local offset = n - num_digs(p-1)
    local nth = math.floor(offset/p)
    local numoffset = offset - (nth * p)

    local num = get_num(p, nth, numoffset)

    -- Debug:
    -- print("p:", p,"offset:",offset, "nth:", nth, "numoffset:", numoffset)
    -- print("dig:", num)
    return num
end


function main()
    local i, prod = 1, 1
    while i <= 1000000 do
        prod = prod * d(i)
        i = i * 10
    end
    print(prod)
end

main()
