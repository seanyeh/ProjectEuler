-- By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that
-- the 6th prime is 13.
-- 
-- What is the 10 001st prime number?

function is_prime(n)
    --assumes input n is odd!!

    local max = math.floor(math.sqrt(n))

    local factors = {}

    for i=3,max,2 do
        if n%i == 0 then
            return false
        end

    end
    return true
end


function get_nth_prime(n)

    local nth = 1
    local num = 1

    while nth < n do
        num = num + 2 -- only check odd numbers

        if is_prime(num) then
            nth = nth + 1
        end

    end

    return num
end

print(get_nth_prime(tonumber(arg[1])))

