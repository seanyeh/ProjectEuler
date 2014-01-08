-- If the numbers 1 to 5 are written out in words: one, two, three, four, five,
--     then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
-- 
-- If all the numbers from 1 to 1000 (one thousand) inclusive were written out in
--     words, how many letters would be used?
-- 
-- NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
-- forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20
-- letters. The use of "and" when writing out numbers is in compliance with
-- British usage.
-- 


lengths = {[1]=3,[2]=3,[3]=5,[4]=4,[5]=4,[6]=3,[7]=5,[8]=5,[9]=4,[0]=0, -- 0 is 0
    [10]=3,[11]=6,[12]=6,[13]=8,[14]=8,[15]=7,[16]=7,[17]=9,[18]=8,[19]=8,
    [20]=6,[30]=6,[40]=5,[50]=5,[60]=5,[70]=7,[80]=6,[90]=6}


HUNDRED = 7
AND = 3

function get_num_length(n)
    if n == 1000 then 
        return 3 + 8 -- one thousand
    end

    local len = 0

    local hundreds_f = n/100
    local hundreds = math.floor(hundreds_f)
    if hundreds > 0 then
        len = lengths[hundreds] + HUNDRED
        
        -- exactly hundred
        if hundreds_f == hundreds then
            return len
        end

        len = len + AND
        n = n - 100*hundreds
    end


    if lengths[n] then
        return len + lengths[n]
    else
        local tens_f = n/10
        local tens = math.floor(tens_f)
        local ones = n - 10*tens


        return len + lengths[tens*10] + lengths[ones]

    end
end


function main()
    local sum = 0
    for i=1,1000 do
        sum = sum + get_num_length(i)
    end
    print(sum)
end

main()
