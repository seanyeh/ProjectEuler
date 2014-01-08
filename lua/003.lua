-- The prime factors of 13195 are 5, 7, 13 and 29.
-- 
-- What is the largest prime factor of the number 600851475143 ?


function get_factors(n)
    local max = math.floor(math.sqrt(n))

    local factors = {}

    for i=1,max do
        if n%i == 0 then
            factors[#factors+1] = i
            factors[#factors+1] = n/i
        end

    end

    table.sort(factors)
    return factors
end


function is_prime(n)
    return n > 1 and #get_factors(n) <= 2
end


function get_largest_prime_factor(n)
    local factors = get_factors(n)

    local i = #factors - 1 -- start from 2nd to last element
    while i > 0 do
        if is_prime(factors[i]) then
            return factors[i]
        end
        i = i - 1
    end
    return -1
end


function print_arr(arr)
    for _,f in ipairs(arr) do
        print(f)
    end
end

print(get_largest_prime_factor(600851475143))
