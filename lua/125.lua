-- The palindromic number 595 is interesting because it can be written as the sum
-- of consecutive squares: 6^2 + 7^2 + 8^2 + 9^2 + 10^2 + 11^2 + 12^2.
--
-- There are exactly eleven palindromes below one-thousand that can be written as
-- consecutive square sums, and the sum of these palindromes is 4164. Note that 1
-- = 0^2 + 1^2 has not been included as this problem is concerned with the squares
-- of positive integers.
--
-- Find the sum of all the numbers less than 10^8 that are both palindromic and can
-- be written as the sum of consecutive squares.


function is_palindrome(n)
    local s = tostring(n)
    for i = 1, #s/2 do
        local rindex = #s - i + 1
        if s:sub(i,i) ~= s:sub(rindex, rindex) then
            return false
        end
    end

    return true
end


function main()
    local max = 100000000
    local square_sums = {}

    for i = 1, 10000 do

        local sum = i*i + (i+1)*(i+1)
        local j = i + 2

        while sum < max do
            if is_palindrome(sum) and sum ~= 0 then
                -- print(i,j - 1,sum)
                square_sums[sum] = true
            end

            sum = sum + j*j
            j = j + 1
        end
    end

    local sum = 0
    for k, _ in pairs(square_sums) do
        sum = sum + k
    end

    print(sum)
end

main()
