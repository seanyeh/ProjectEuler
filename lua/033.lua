-- The fraction 49/98 is a curious fraction, as an inexperienced mathematician in
-- attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is
-- correct, is obtained by cancelling the 9s.
--
-- We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
--
-- There are exactly four non-trivial examples of this type of fraction, less than
-- one in value, and containing two digits in the numerator and denominator.
--
-- If the product of these four fractions is given in its lowest common terms,
--     find the value of the denominator.


function reverse_1_2(i)
    if i == 1 then
        return 2
    else
        return 1
    end
end


function cancel(a,b)
    local stra = tostring(a)
    local strb = tostring(b)

    for i=1,2 do
        for j=1,2 do
            local d1, d2 = string.sub(a,i,i), string.sub(b,j,j)
            if d1 ~= "0" and d1 == d2 then
                local ti, tj = reverse_1_2(i), reverse_1_2(j)
                local tn, td =  string.sub(a,ti,ti), string.sub(b,tj,tj)
                return tonumber(tn)/tonumber(td)
            end
        end
    end

    return -1
end


function main()
    local num = 1
    local den = 1
    for a=10,99 do
        for b=a+1,99 do
            local res = a/b
            if res == cancel(a,b) then
                num = num * a
                den = den * b
            end
        end
    end
    print(num,den) 
    -- returns 387296, 38729600, so simplified denominator is 100
end

main()
