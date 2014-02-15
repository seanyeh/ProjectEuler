-- The prime 41, can be written as the sum of six consecutive primes: 41 = 2 + 3 +
-- 5 + 7 + 11 + 13
--
-- This is the longest sum of consecutive primes that adds to a prime below
-- one-hundred.
--
-- The longest sum of consecutive primes below one-thousand that adds to a prime,
-- contains 21 terms, and is equal to 953.
--
-- Which prime, below one-million, can be written as the sum of the most
-- consecutive primes?

PRIMES, NTHPRIMES = {}, {}

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


function main()
    -- generate primes
    for i = 2,1000000 do
        if is_prime(i) then
            PRIMES[i] = 1
            NTHPRIMES[#NTHPRIMES+1] = i
        end
    end

    local MAX = 1000000
    local maxsum, maxlen = 0, 0
    for start = 1,#NTHPRIMES do
        local tempsum = 0
        for i = start, #NTHPRIMES do
            tempsum = tempsum + NTHPRIMES[i]
            if tempsum > MAX then break end

            if i-start > maxlen and is_prime(tempsum) then
                maxlen = i - start
                maxsum = tempsum
            end
        end
    end

    print(maxsum)
end

main()
