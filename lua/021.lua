-- Let d(n) be defined as the sum of proper divisors of n (numbers less than n
-- which divide evenly into n).  If d(a) = b and d(b) = a, where a ≠ b, then a and
-- b are an amicable pair and each of a and b are called amicable numbers.
-- 
-- For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55
--     and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71
--     and 142; so d(284) = 220.
-- 
-- Evaluate the sum of all the amicable numbers under 10000.
-- 


function get_sum_factors(n)
    local max = math.floor(n/2)

    local sum = 0
    for i=1,max do
        if n%i == 0 then
            sum = sum + i
        end
    end

    return sum
end


function create_sum_table()
    t = {}
    for i=1,9999 do
        t[i] = get_sum_factors(i)
    end
    return t
end


-- Sort of brute forcing I guess :) 0.22s with luajit though so not bad
function main()
    t = create_sum_table()

    local sum = 0
    for i=1,9998 do
        for j=i+1,9999 do
            if t[i] == j and t[j] == i then
                sum = sum + i + j
            end
        end
    end

    print(sum)
end

main()
