-- The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
--
-- Find the sum of all numbers, less than one million, which are palindromic in
-- base 10 and base 2.
--
-- (Please note that the palindromic number, in either base, may not include
-- leading zeros.)


function is_palindrome(s)
    for i=1,math.floor(#s/2) do
        local x = string.sub(s, i, i)
        local y = string.sub(s, #s-i+1, #s-i+1)

        if x ~= y then
            return false
        end
    end

    return true
end


function to_binary_str(n)
    -- perhaps not the most efficient way

    -- find max power
    local div = 1
    while n >= div do
        div = div * 2
    end
    div = div/2

    local s = ""
    while div >= 1 do
        if n >= div then
            n =  n - div
            s = s.."1"
        else
            s = s.."0"
        end
        div = div / 2
    end
    return s
end


function is_double_palindrome(n)
    return is_palindrome(tostring(n)) and is_palindrome(to_binary_str(n))
end


function main()
    local sum = 0
    for i=1,1000000 do
        if is_double_palindrome(i) then
            sum = sum + i
        end
    end
    print(sum)
end

main()
