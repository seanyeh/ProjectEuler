-- A perfect number is a number for which the sum of its proper divisors is
-- exactly equal to the number. For example, the sum of the proper divisors of 28
-- would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
-- 
-- A number n is called deficient if the sum of its proper divisors is less than n
-- and it is called abundant if this sum exceeds n.
-- 
-- As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
-- number that can be written as the sum of two abundant numbers is 24. By
-- mathematical analysis, it can be shown that all integers greater than 28123 can
-- be written as the sum of two abundant numbers. However, this upper limit cannot
-- be reduced any further by analysis even though it is known that the greatest
-- number that cannot be expressed as the sum of two abundant numbers is less than
-- this limit.
-- 
-- Find the sum of all the positive integers which cannot be written as the sum of
-- two abundant numbers.
-- 

MAX = 28123

function get_sum_factors(n)
    local max = math.floor(math.sqrt(n))

    local sum = 1

    for i=2,max do
        if n%i == 0 then
            sum = sum + i

            -- that way we don't double count squared numbers
            if i ~= n/i then
                sum = sum + n/i
            end
        end

    end

    return sum
end

function is_abundant(n)
    return get_sum_factors(n) > n
end


function get_abundant_numbers()
    local numbers = {}

    -- 12 is the smallest abundant number
    for i=12,MAX do
        if is_abundant(i) then
            numbers[#numbers+1] = i
        end
    end
    return numbers
end

ABUNDANT_NUMBERS = get_abundant_numbers()

function main()
    local nums = {}
    for i=1,#ABUNDANT_NUMBERS do
        for j=1, #ABUNDANT_NUMBERS do
            local a,b = ABUNDANT_NUMBERS[i], ABUNDANT_NUMBERS[j]
            nums[a+b] = 1
        end
    end


    local sum = 0
    for i=1,MAX do
        if not nums[i] then
            sum = sum + i
        end
    end

    print(sum)
end

main()
