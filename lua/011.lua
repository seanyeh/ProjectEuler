
NUM = "08022297381500400075040507785212507791084949994017811857608717409843694804566200814931735579142993714067538830034913366552709523046011426924685601325671370236912231167151676389419236542240402866331380244732609903450244753353783684203517125032988128642367102638406759547066183864706726206802621220956394396308409166499421245558056673992697177878968314883489637221362309750076442045351400613397343133957817532822753167159403800462161409535692163905429635314755588824001754243629855786560048357189070544443744602158515417581980816805944769287392138652177704895540045208839735991607975732162626793327986688366887576220720346336746551232639353690442167338253911249472180846293240627636206936417230238834629969826759857404361620733529783190017431497148868116235705540170547183515469169233486143520189196748"

function get_seq(row, col, f)
    local prod = 1
    for i=1,4 do
        prod = prod * get_num(row, col)
        row, col = f(row, col)
    end
    return prod
end

function get_col(row, col)
    return get_seq(row, col, function(r,c) return r+1, c end)
end

function get_row(row, col)
    return get_seq(row, col, function(r,c) return r, c+1 end)
end

function get_diag_r(row, col)
    return get_seq(row, col, function(r,c) return r+1, c+1 end)
end

function get_diag_l(row, col)
    return get_seq(row, col, function(r,c) return r+1, c-1 end)
end

-- rows and cols start from 1, not 0
function get_num(row, col)
    local index = 40 * (row-1) + 2*col - 1
    local str = string.sub(NUM, index, index+1)
    return tonumber(str)
end


function main()
    max = 0
    -- check rows
    for row=1,20 do
        for col=1,17 do
            local temp = get_row(row,col)
            if temp > max then max = temp end
        end
    end
            

    -- check cols
    for row=1,17 do
        for col=1,20 do
            local temp = get_col(row,col)
            if temp > max then max = temp end
        end
    end


    -- check diag_r
    for row=1,17 do
        for col=1,17 do
            local temp = get_diag_r(row,col)
            if temp > max then max = temp end
        end
    end


    -- check diag_l
    for row=1,17 do
        for col=4,20 do
            local temp = get_diag_l(row,col)
            if temp > max then max = temp end
        end
    end

    print(max)
end

main()
