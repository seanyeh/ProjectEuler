-- There are exactly ten ways of selecting three from five, 12345:
--
-- 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
--
-- In combinatorics, we use the notation, 5C3 = 10.
--
-- In general,
-- nCr = n!/r!(n−r)!,where r ≤ n, n! = n×(n−1)×...×3×2×1, and 0! = 1.
--
-- It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.
--
-- How many, not necessarily distinct, values of  nCr, for 1 ≤ n ≤ 100, are
-- greater than one-million?

-- first time doing fac the iterative way :)
function fac(n)
    local prod = 1
    for i = 1, n do
        prod = prod * i
    end
    return prod
end


function c(n, r)
    return fac(n)/(fac(r) * fac(n-r))
end


function main()
    local num = 0
    for n = 1, 100 do
        for r = 1, 100 do
            if c(n,r) > 1000000 then
                num = num + 1
            end
        end
    end
    print(num)
end

main()
