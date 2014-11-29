-- Some positive integers n have the property that the sum [ n + reverse(n) ]
-- consists entirely of odd (decimal) digits. For instance, 36 + 63 = 99 and 409 +
-- 904 = 1313. We will call such numbers reversible; so 36, 63, 409, and 904 are
-- reversible. Leading zeroes are not allowed in either n or reverse(n).
--
-- There are 120 reversible numbers below one-thousand.
--
-- How many reversible numbers are there below one-billion (10^9)?


function is_reversible(arr)
    local carry = 0
    for i=1,#arr do
        local sum = arr[i] + arr[#arr - i + 1]
        if (sum + carry)%2 ==0 then
            return false
        end

        if sum >= 10 then carry = 1 else carry = 0 end
    end

    return true
end


-- Return false if reached all 9 digits
-- Otherwise, increment next digit
function get_next_index(arr)
    for i=#arr,1,-1 do
        if arr[i] == 9 then
            -- Start from 1 instead of 0 if last digit
            if i == #arr then
                arr[i] = 1
            else
                arr[i] = 0
            end
        else
            arr[i] = arr[i] + 1
            return true
        end
    end

    return false
end


function next_arr_gen()
    local arr = {1}
    while true do
        coroutine.yield(arr)

        if not get_next_index(arr) then
            local len = #arr - 1
            arr = {1}
            for i=1,len do
                arr[#arr + 1] = 0
            end
            arr[#arr + 1] = 1
        end

    end
end


function next_arr_it()
    local co = coroutine.create(function() next_arr_gen() end)
    return function()
        local _, res = coroutine.resume(co)
        return res
    end
end


function main()
    local count = 0
    for arr in next_arr_it() do
        if #arr > 8 then
            break
        end

        if is_reversible(arr) then
            count = count + 1
        end
    end

    print(count)
end

main()
