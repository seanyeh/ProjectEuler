-- The number 145 is well known for the property that the sum of the factorial of
-- its digits is equal to 145:
--
-- 1! + 4! + 5! = 1 + 24 + 120 = 145
--
-- Perhaps less well known is 169, in that it produces the longest chain of
-- numbers that link back to 169; it turns out that there are only three such
-- loops that exist:
--
-- 169 → 363601 → 1454 → 169 871 → 45361 → 871 872 → 45362 → 872
--
-- It is not difficult to prove that EVERY starting number will eventually get
-- stuck in a loop. For example,
--
-- 69 → 363600 → 1454 → 169 → 363601 (→ 1454) 78 → 45360 → 871 → 45361 (→ 871) 540
-- → 145 (→ 145)
--
-- Starting with 69 produces a chain of five non-repeating terms, but the longest
-- non-repeating chain with a starting number below one million is sixty terms.
--
-- How many chains, with a starting number below one million, contain exactly
-- sixty non-repeating terms?
--

CHAINS = {
    [169] = 3,
    [363601] = 3,
    [1454] = 3,
    [871] = 2,
    [45361] = 2,
    [872] = 2,
    [45362] = 2
}

FACS = {}

function fac_s(s)
    if FACS[s] then return FACS[s] end

    local n = tonumber(s)
    local prod = 1
    for i = 2, n do
        prod = prod * i
    end

    FACS[s] = prod
    return prod
end


function get_fac_digs(n)
    local s = tostring(n)
    local sum = 0
    for i = 1, #s do
        local c = s:sub(i,i)
        sum = sum + fac_s(c)
    end

    return sum
end


function get_num_chains(n, levels)
    levels = levels or 0

    -- cheating here a little: just stop once it passes 60
    if levels > 60 then return 61 end

    if CHAINS[n] then return CHAINS[n] end

    local num = 1 + get_num_chains(get_fac_digs(n), levels + 1)
    CHAINS[n] = num
    return num
end


function main()
    local nums = 0
    for i = 2, 999999 do
        local chains = get_num_chains(i)
        if chains == 60 then
            nums = nums + 1
        end
    end

    print(nums)
end

main()
