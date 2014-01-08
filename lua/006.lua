-- 
-- The sum of the squares of the first ten natural numbers is, 12 + 22 + ... + 102
-- = 385
-- 
-- The square of the sum of the first ten natural numbers is, (1 + 2 + ... + 10)2
-- = 552 = 3025
-- 
-- Hence the difference between the sum of the squares of the first ten natural
-- numbers and the square of the sum is 3025 − 385 = 2640.
-- 
-- Find the difference between the sum of the squares of the first one hundred
-- natural numbers and the square of the sum.


function sum(n, f)
    -- similar to a functional reduce
    local sum = 0
    for i=1,n do
        sum = sum + f(i)
    end
    return sum
end

function get_difference(n)
    local f_id = function(x) return x end
    local f_sq = function(x) return math.pow(x,2) end

    return math.pow(sum(n, f_id), 2) - sum(n, f_sq)
end

print(get_difference(100))
