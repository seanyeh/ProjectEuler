-- A palindromic number reads the same both ways. The largest palindrome made
-- from the product of two 2-digit numbers is 9009 = 91 × 99.
-- 
-- Find the largest palindrome made from the product of two 3-digit numbers.


function is_palindrome(n)
    local s = string.format("%d",n)

    for i=1,math.floor(#s/2) do
        local x = string.sub(s, i, i)
        local y = string.sub(s, #s-i+1, #s-i+1)

        if x ~= y then
            return false
        end
    end

    return true
end


function get_palindromes(start, finish)
    local palindromes={}

    for i=start,finish do
        for j=i,finish do
            local prod = i*j
            if is_palindrome(prod) then
                palindromes[#palindromes+1] = prod
            end
        end
    end
    return palindromes
end


-- searching from 900 should be good enough
p = get_palindromes(900,1000)
table.sort(p)
print(p[#p])
