function get_combos(n)
    local sums = {
        [0] = 1,
    }

    for i=1,n do
        local new_sum = sums[#sums]

        -- red
        if sums[i-2] ~= nil then
            new_sum = new_sum + sums[i-2]
        end

        -- green
        if sums[i-3] ~= nil then
            new_sum = new_sum + sums[i-3]
        end

        -- blue
        if sums[i-4] ~= nil then
            new_sum = new_sum + sums[i-4]
        end


        sums[#sums+1] = new_sum
    end

    return sums[#sums]
end


function main()
    print(get_combos(50))
end

main()
