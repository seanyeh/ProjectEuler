-- n! means n × (n − 1) × ... × 3 × 2 × 1
-- 
-- For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800, and the sum of the
--     digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
-- 
-- Find the sum of the digits in the number 100!


-- didn't use this because I was having problems with Lua + precision
function fac(n)
    if n == 1 then
        return 1
    end
    return n * fac(n-1)
end


function main()
    local s = string.format("%f",fac(100))
    print(s)

    local sum = 0
    for i=1,string.find(s,".",1, true)-1 do
        sum = sum + tonumber(string.sub(s,i,i))
    end

    print(sum)
end

main()
