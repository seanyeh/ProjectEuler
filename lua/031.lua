-- In England the currency is made up of pound, £, and pence, p, and there are
-- eight coins in general circulation:
--
--     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
--
-- It is possible to make £2 in the following way:
--
--     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
--
-- How many different ways can £2 be made using any number of coins?


-- math with floats is always wonky
COINS = {200,100,50,20,10,5,2,1}
GOAL = 200

-- Generate num of possibilities using coins <= max_coin
function possibilities(sum, max_coin_i)
    if sum == GOAL then 
        return 1 
    elseif sum < GOAL then
        local num_poss = 0
        for i=max_coin_i,#COINS do
            num_poss = num_poss + possibilities(sum + COINS[i], i)
        end
        return num_poss
    else
        return 0
    end
end


function main()
    print(possibilities(0,1))

end

main()
