-- If p is the perimeter of a right angle triangle with integral length sides,
--     {a,b,c}, there are exactly three solutions for p = 120.
--
-- {20,48,52}, {24,45,51}, {30,40,50}
--
-- For which value of p ≤ 1000, is the number of solutions maximised?

TRIANGLES = {}

function main()
    local max = 1000
    for a=1,500 do
        for b=a,500 do
            local c = math.sqrt(a*a + b*b)
            local p = a + b + c
            if p <= max and c == math.floor(c) then
                local num = TRIANGLES[p] or 0
                TRIANGLES[p] = num + 1
            end
        end
    end

    local maxk, maxv = -1, -1
    for k,v in pairs(TRIANGLES) do
        if v > maxv then
            maxk, maxv = k, v
        end
    end

    print(maxk)
end

main()
