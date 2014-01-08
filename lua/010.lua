-- The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
-- 
-- Find the sum of all the primes below two million.


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


function sum_primes(max)
    local num = 3
    local sum = 2 -- 2 is the first prime

    while num < max do
        if (is_prime(num)) then
            sum = sum + num
        end
        num = num + 2
    end
    return sum
end

print(sum_primes(2000000))
