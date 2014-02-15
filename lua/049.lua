-- The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases
-- by 3330, is unusual in two ways: (i) each of the three terms are prime, and,
-- (ii) each of the 4-digit numbers are permutations of one another.
--
-- There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes,
-- exhibiting this property, but there is one other 4-digit increasing sequence.
--
-- What 12-digit number do you form by concatenating the three terms in this
-- sequence?

PRIMES = {}

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


function get_digs(n)
    local digs = {}
    while n > 0 do
        digs[#digs+1] = n%10
        n = math.floor(n/10)
    end

    return digs
end


function is_permutation(n1, n2)
    local d1, d2 = get_digs(n1), get_digs(n2)

    if #d1 ~= #d2 then return false end

    table.sort(d1)
    table.sort(d2)
    return table.concat(d1) == table.concat(d2)
end

function main()
    -- generate primes
    for i=1000,9999 do
        if is_prime(i) then
            PRIMES[i] = 1
        end
    end

    for p,_ in pairs(PRIMES) do
        for i = 1, (9999-p)/2 do
            -- each is prime
            if PRIMES[p+i] and PRIMES[p+2*i] then
                -- is permutation and not
                if is_permutation(p,p+i) and is_permutation(p, p+2*i) then
                    -- not example
                    if p ~= 1487 then
                        print(table.concat({p, p+i, p+2*i}))
                    end
                end
            end
        end
    end
end

main()
