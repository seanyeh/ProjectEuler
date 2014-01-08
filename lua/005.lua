-- 2520 is the smallest number that can be divided by each of the numbers from 1
-- to 10 without any remainder.
-- 
-- What is the smallest positive number that is evenly divisible by all of the
-- numbers from 1 to 20?


function is_divisible_to(max, num)
    for i = 2,max do
        if num%i ~= 0 then
            return false
        end
    end
    return true
end


function find_smallest()
    local delta = 4849845 -- product of all primes under 20
    local x = delta

    while true do
        if is_divisible_to(20,x) then
            return x
        end
        x = x+delta
    end
end


print(find_smallest())
