-- The sequence of triangle numbers is generated by adding the natural numbers. So
-- the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten
-- terms would be:
-- 
-- 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
-- 
-- Let us list the factors of the first seven triangle numbers:
-- 
--      1: 1 3: 1,3 6: 1,2,3,6 10: 1,2,5,10 15: 1,3,5,15 21: 1,3,7,21 28:
--      1,2,4,7,14,28
-- 
-- We can see that 28 is the first triangle number to have over five divisors.
-- 
-- What is the value of the first triangle number to have over five hundred
-- divisors?
-- 


function get_num_factors(n)
    local max = math.floor(math.sqrt(n))

    local num = 0
    for i=1,max do
        if n%i == 0 then
            num = num + 1
        end

    end
    return 2*num
end


function main()
    local i = 1
    local tri = 0
    while true do
        tri = tri + i
        local num = get_num_factors(tri)

        if (num > 500) then
            print(tri)
            return
        end

        i = i + 1
    end
end

main()
