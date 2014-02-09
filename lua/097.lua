-- The first known prime found to exceed one million digits was discovered in
-- 1999, and is a Mersenne prime of the form 26972593−1; it contains exactly
-- 2,098,960 digits. Subsequently other Mersenne primes, of the form 2p−1, have
-- been found which contain more digits.
--
-- However, in 2004 there was found a massive non-Mersenne prime which contains
-- 2,357,207 digits: 28433×27830457+1.
--
-- Find the last ten digits of this prime number.


function main()
    -- Avoiding the use of big nums :)
    local pow = 7830457
    local tendigs = 10000000000

    -- get the last 10 digits of prod
    local prod = 1
    for i= 1, pow do
        prod = (prod * 2) % tendigs
    end

    local itself = prod
    -- add to itself 28432 times :)
    for i = 1, 28432 do
        prod = (prod + itself) % tendigs
    end

    local result = tostring(prod + 1)
    print(result:sub(#result-9,#result))
end

main()
