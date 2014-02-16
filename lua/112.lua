-- Working from left-to-right if no digit is exceeded by the digit to its left it
-- is called an increasing number; for example, 134468.
--
-- Similarly if no digit is exceeded by the digit to its right it is called a
-- decreasing number; for example, 66420.
--
-- We shall call a positive integer that is neither increasing nor decreasing a
-- "bouncy" number; for example, 155349.
--
-- Clearly there cannot be any bouncy numbers below one-hundred, but just over
-- half of the numbers below one-thousand (525) are bouncy. In fact, the least
-- number for which the proportion of bouncy numbers first reaches 50% is 538.
--
-- Surprisingly, bouncy numbers become more and more common and by the time we
-- reach 21780 the proportion of bouncy numbers is equal to 90%.
--
-- Find the least number for which the proportion of bouncy numbers is exactly
-- 99%.

function is_inc(n, multiplier)
    multiplier = multiplier or 1
    local s = tostring(n)
    for i = 1, #s-1 do
        local n1, n2 = tonumber(s:sub(i,i)), tonumber(s:sub(i+1,i+1))
        if multiplier*n1 > multiplier*n2 then
            return false
        end
    end
    return true
end


function is_dec(n) return is_inc(n, -1) end


function is_bouncy(n)
    return not (is_inc(n) or is_dec(n))
end


function main()
    local i = 1
    local bouncies, total = 0, 0
    while total == 0 or bouncies/total < 0.99 do
        total = total + 1
        if is_bouncy(i) then
            bouncies = bouncies + 1
        end

        i = i + 1
    end

    print(i-1)
end

main()
