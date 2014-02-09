-- It was proposed by Christian Goldbach that every odd composite number can be
-- written as the sum of a prime and twice a square.
--
-- 9 = 7 + 2×12
-- 15 = 7 + 2×22
-- 21 = 3 + 2×32
-- 25 = 7 + 2×32
-- 27 = 19 + 2×22
-- 33 = 31 + 2×12
--
-- It turns out that the conjecture was false.
--
-- What is the smallest odd composite that cannot be written as the sum of a prime
-- and twice a square?

PRIMES = {}
COMPS = {}

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


-- assumes n is composite
-- if even, return true
function is_valid(n)
    if n%2 == 0 then return true end

    for i=1,math.sqrt(n/2) do
        local diff = n - 2*i*i
        if PRIMES[diff] then
            return true
        end
    end
    return false
end


function main()
    -- generate primes and comps
    for i=2,1000000 do
        if is_prime(i) then
            PRIMES[i] = 1
        else
            COMPS[i] = 1
        end
    end

    for v, _ in pairs(COMPS) do
        if not is_valid(v) then
            print(v)
            break
        end
    end
end

main()
