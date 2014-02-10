-- The first two consecutive numbers to have two distinct prime factors are:
--
-- 14 = 2 × 7
-- 15 = 3 × 5
--
-- The first three consecutive numbers to have three distinct prime factors are:
--
-- 644 = 2² × 7 × 23
-- 645 = 3 × 5 × 43
-- 646 = 2 × 17 × 19.
--
-- Find the first four consecutive integers to have four distinct prime factors.
-- What is the first of these numbers

PRIMES = {[2]=1}
NTHPRIMES = {2}


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


function get_prime_factors(n)
    if PRIMES[n] then 
        return 1, {n}
    end

    for _, p in pairs(NTHPRIMES) do
        if n%p == 0 then
            local num_primes, primes = get_prime_factors(n/p)
            
            if not primes[p] then
                primes[p] = 1
                num_primes = num_primes + 1
            end

            return num_primes, primes
        end

        if p >= n then break end
    end
end


function main()
    -- generate primes
    for i=3,1000000 do
        if is_prime(i) then
            PRIMES[i] = 1
            NTHPRIMES[#NTHPRIMES+1] = i
        end
    end

    local consec = 0
    for i = 100, 1000000 do
        local facs, _ = get_prime_factors(i)
        if facs >= 4 then
            consec = consec + 1
        else
            consec = 0
        end

        if consec >= 4 then
            print(i-3)
            break
        end
    end
end

main()
