-- A number chain is created by continuously adding the square of the digits in a
-- number to form a new number until it has been seen before.
--
-- For example,
--
-- 44 → 32 → 13 → 10 → 1 → 1
-- 85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89
--
-- Therefore any chain that arrives at 1 or 89 will become stuck in an endless
-- loop. What is most amazing is that EVERY starting number will eventually arrive
-- at 1 or 89.
--
-- How many starting numbers below ten million will arrive at 89?

ARR1 = {[1]=1}
ARR89 = {[89]=1}

function sq_digs(n)
    local sum = 0
    while n > 0 do
        local dig = n%10
        sum = sum + dig * dig
        n = math.floor(n/10)
    end
    return sum
end


function is_89(n)
    if ARR89[n] then 
        return true
    elseif ARR1[n] then
        return false
    else
        local sum = sq_digs(n)
        local res = is_89(sum)
        
        -- cache results
        if res then
            ARR89[n] = 1
        else
            ARR1[n] = 1
        end

        return res
    end
end


function main()
    local nums = 0
    for i = 1, 9999999 do
        if is_89(i) then
            nums = nums + 1
        end
    end
    print(nums)
end

main()
