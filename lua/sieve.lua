-- sieve of eratosthenes
function sieve(max)
    local cache = {}
    for i = 2, max/2 do
        local x = 2 * i

        -- if i is prime
        if not cache[i] then
            while x < max do
                cache[x] = true

                x = x + i
            end
        end
    end

    local primes = {}
    local primes_hash = {}
    for i = 2, max do
        if not cache[i] then
            primes[#primes + 1] = i
            primes_hash[i] = true
        end
    end

    return primes, primes_hash
end
