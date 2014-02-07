-- The number 3797 has an interesting property. Being prime itself, it is possible
-- to continuously remove digits from left to right, and remain prime at each
-- stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797,
-- 379, 37, and 3.
--
-- Find the sum of the only eleven primes that are both truncatable from left to
-- right and right to left.
--
-- NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.


function is_prime(n)
    -- special cases: 2 is prime, 1 is not
    if n == 1 then return false end
    if n == 2 then return true end
    -- even: false
    if n%2 == 0 then return false end

    -- else:
    local max = math.floor(math.sqrt(n))
    for i=3,max,2 do
        if n%i == 0 then
            return false
        end
    end
    return true
end


function is_trunc_prime(n)
    if not is_prime(n) then return false end

    local s = tostring(n)
    for i=1,#s-1 do
        local i1 = tonumber(string.sub(s,i+1, #s))
        local i2 = tonumber(string.sub(s,1, #s - i))
        if (not is_prime(i1)) or (not is_prime(i2)) then
            return false
        end
    end
    return true
end


function main()
    local sum = 0
    for i = 10, 1000000 do
        if is_trunc_prime(i) then
            sum = sum + i
        end
    end

    print(sum)
end

main()
