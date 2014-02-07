-- The number, 197, is called a circular prime because all rotations of the
-- digits: 197, 971, and 719, are themselves prime.
--
-- There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71,
-- 73, 79, and 97.
--
-- How many circular primes are there below one million?


function is_prime(n)
    -- special cases: 2 is prime
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


function get_rotations(n)
    local rots = {n}
    local s = tostring(n)

    for i=2,#s do
        rots[#rots+1] = tonumber(string.sub(s,i,#s)..string.sub(s,1,i-1))
    end

    return rots
end


function is_circular_prime(n)
    for _, v in pairs(get_rotations(n)) do
        if not is_prime(v) then
            return false
        end
    end
    return true
end


function main()
    local max = 1000000
    local nums = 0
    for i=1,max,2 do
        if is_circular_prime(i) then
            nums = nums + 1
        end
    end
    print(nums)
end

main()
