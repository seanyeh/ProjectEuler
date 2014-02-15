-- If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.
--
-- Not all numbers produce palindromes so quickly. For example,
--
-- 349 + 943 = 1292, 1292 + 2921 = 4213 4213 + 3124 = 7337
--
-- That is, 349 took three iterations to arrive at a palindrome.
--
-- Although no one has proved it yet, it is thought that some numbers, like
-- 196, never produce a palindrome. A number that never forms a palindrome
-- through the reverse and add process is called a Lychrel number. Due to the
-- theoretical nature of these numbers, and for the purpose of this problem,
-- we shall assume that a number is Lychrel until proven otherwise. In
-- addition you are given that for every number below ten-thousand, it will
-- either (i) become a palindrome in less than fifty iterations, or, (ii) no
-- one, with all the computing power that exists, has managed so far to map it
-- to a palindrome. In fact, 10677 is the first number to be shown to require
-- over fifty iterations before producing a palindrome:
-- 4668731596684224866951378664 (53 iterations, 28-digits).
--
-- Surprisingly, there are palindromic numbers that are themselves Lychrel
-- numbers; the first example is 4994.
--
-- How many Lychrel numbers are there below ten-thousand?
--
-- NOTE: Wording was modified slightly on 24 April 2007 to emphasise the
-- theoretical nature of Lychrel numbers.

local bc = require("bc")

function is_palindrome(n)
    local s = tostring(n)
    for i=1,math.floor(#s/2) do
        local x = string.sub(s, i, i)
        local y = string.sub(s, #s-i+1, #s-i+1)

        if x ~= y then
            return false
        end
    end
    return true
end


function reverse(n)
    local s = tostring(n)
    local rev = string.reverse(tostring(n))
    return tonumber(rev)
end


function exists_palindrome_sum(n)
    for i = 1, 50 do
        local sum = bc.add(n, reverse(n))
        if is_palindrome(sum) then
            return true
        end
        n = sum
    end
    return false
end


function main()
    local num = 0
    for i = 1, 9999 do
        if not exists_palindrome_sum(i) then
            num = num + 1
        end
    end
    print(num)
end

main()
