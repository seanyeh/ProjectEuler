-- A permutation is an ordered arrangement of objects. For example, 3124 is one
-- possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
-- are listed numerically or alphabetically, we call it lexicographic order. The
-- lexicographic permutations of 0, 1 and 2 are:
-- 
-- 012   021   102   120   201   210
-- 
-- What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5,
-- 6, 7, 8 and 9?

function fac(n)
    if n <= 1 then return 1 end
    return n * fac(n-1)
end

function main()
    local digits = {0,1,2,3,4,5,6,7,8,9}
    local xth=1000000

    local answer=""
    while #digits > 0 do
        local ppd = fac(#digits)/#digits --possibilities per digit
        local x = math.floor(xth/ppd) + 1 -- lua starts indexes from 1

        -- probably a better way to do this
        if xth%ppd == 0 and x > 0 then
            x = x - 1
        end

        answer = answer..tostring(digits[x])
        table.remove(digits, x)
        xth = xth - (x-1) * ppd
    end

    print(answer)
end

main()
