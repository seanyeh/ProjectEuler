-- Euler discovered the remarkable quadratic formula:
-- 
-- n² + n + 41
-- 
-- It turns out that the formula will produce 40 primes for the consecutive values
-- n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible
-- by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.
-- 
-- The incredible formula  n² − 79n + 1601 was discovered, which produces 80
-- primes for the consecutive values n = 0 to 79. The product of the coefficients,
-- −79 and 1601, is −126479.
-- 
-- Considering quadratics of the form:
-- 
--     n² + an + b, where |a| < 1000 and |b| < 1000
-- 
--     where |n| is the modulus/absolute value of n
--     e.g. |11| = 11 and |−4| = 4
-- 
-- Find the product of the coefficients, a and b, for the quadratic expression
-- that produces the maximum number of primes for consecutive values of n,
-- starting with n = 0.
-- 

function is_prime(n)
    if n <= 1 then return false end
    if n == 2 then return true end

    local max = math.floor(math.sqrt(n))

    local factors = {}

    for i=3,max,2 do
        if n%i == 0 then
            return false
        end

    end
    return true
end


-- will also generate negative versions of the primes
function generate_primes()
    local primes={}
    for i=3,999,2 do
        if is_prime(i) then
            primes[#primes+1] = i
            primes[#primes+1] = -i
        end
    end
    return primes
end


function num_consecutive(a,b)
    local n = 1
    while is_prime(n*n + a*n + b) do
        n = n + 1
    end

    return n-1
end


function main()
    local primes = generate_primes()
    local max_consec, max_prod = 0, 0
    for i=1,#primes do
        for j = 1, #primes do
            local a, b = primes[i], primes[j]
            local consec = num_consecutive(a,b)
            if consec > max_consec then
                max_consec, max_prod = consec, a*b
            end
        end
    end
    print(max_prod)
end

main()
