-- In the card game poker, a hand consists of five cards and are ranked, from
-- lowest to highest, in the following way:
--
--     High Card: Highest value card.
--     One Pair: Two cards of the same value.
--     Two Pairs: Two different pairs.
--     Three of a Kind: Three cards of the same value.
--     Straight: All cards are consecutive values.
--     Flush: All cards of the same suit.
--     Full House: Three of a kind and a pair.
--     Four of a Kind: Four cards of the same value.
--     Straight Flush: All cards are consecutive values of same suit.
--     Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
--
-- The cards are valued in the order:
-- 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
--
-- If two players have the same ranked hands then the rank made up of the highest
--     value wins; for example, a pair of eights beats a pair of fives (see
--     example 1 below). But if two ranks tie, for example, both players have a
--     pair of queens, then highest cards in each hand are compared (see example 4
--     below); if the highest cards tie then the next highest cards are compared,
--     and so on.
--
-- Consider the following five hands dealt to two players:
-- Hand	 	Player 1	 	Player 2	 	Winner
-- 1	 	5H 5C 6S 7S KD
-- Pair of Fives
-- 	 	2C 3S 8S 8D TD
-- Pair of Eights
-- 	 	Player 2
-- 2	 	5D 8C 9S JS AC
-- Highest card Ace
-- 	 	2C 5C 7D 8S QH
-- Highest card Queen
-- 	 	Player 1
-- 3	 	2D 9C AS AH AC
-- Three Aces
-- 	 	3D 6D 7D TD QD
-- Flush with Diamonds
-- 	 	Player 2
-- 4	 	4D 6S 9H QH QC
-- Pair of Queens
-- Highest card Nine
-- 	 	3D 6D 7H QD QS
-- Pair of Queens
-- Highest card Seven
-- 	 	Player 1
-- 5	 	2H 2D 4C 4D 4S
-- Full House
-- With Three Fours
-- 	 	3C 3D 3S 9S 9D
-- Full House
-- with Three Threes
-- 	 	Player 1
--
-- The file, poker.txt, contains one-thousand random hands dealt to two players.
-- Each line of the file contains ten cards (separated by a single space): the
-- first five are Player 1's cards and the last five are Player 2's cards. You can
-- assume that all hands are valid (no invalid characters or repeated cards), each
-- player's hand is in no specific order, and in each hand there is a clear
-- winner.
--
-- How many hands does Player 1 win?

local HANDS = {
    ["HIGH"] = 0,
    ["PAIR"] = 1,
    ["TWO_PAIR"] = 2,
    ["THREE_KIND"] = 3,
    ["STRAIGHT"] = 4,
    ["FLUSH"] = 5,
    ["FH"] = 6,
    ["FOUR_KIND"] = 7,
    ["SFLUSH"] = 8,
    ["RFLUSH"] = 9
}

local ROYALS = {
    ["T"] = 10,
    ["J"] = 11,
    ["Q"] = 12,
    ["K"] = 13,
    ["A"] = 14
}

function get_num(c)
    local n = c:sub(1,1)
    if ROYALS[n] then
        return ROYALS[n]
    else
        return tonumber(n)
    end
end


function get_suit(c)
    return c:sub(2,2)
end


function is_flush(cards)
    local suit = get_suit(cards[1])
    for i = 2, #cards do
        if suit ~= get_suit(cards[i]) then
            return false
        end
    end
    return true
end


function is_straight(cards)
    local prev_n = get_num(cards[#cards])

    local nonseq = 0
    for i = 1, #cards do
        local n = get_num(cards[i])
        if (n - prev_n)%13 ~= 1 then
            nonseq = nonseq + 1
            if nonseq > 1 then
                return false
            end
        end

        prev_n = n
    end
    return true
end


function get_binned_cards(cards)
    local bins = {}
    for _, c in pairs(cards) do
        local n = get_num(c)
        local index = #bins + 1

        -- change index if same number exists in hand
        for i, c2 in ipairs(bins) do
            if get_num(c2[1]) == n then index = i end
        end

        if not bins[index] then
            bins[index] = {}
        end
        -- append c to bins[index]
        bins[index][#bins[index]+1] = c
    end
    

    function bin_cmp(a,b)
        if #a ~= #b then
            return #a > #b
        end
        return get_num(a[1]) > get_num(b[1])
    end

    table.sort(bins, bin_cmp)
    return bins
end




function get_hand(cards)
    table.sort(cards, function(a,b) 
        return get_num(a) < get_num(b) 
    end)

    local hand = HANDS.HIGH

    local binned_cards = get_binned_cards(cards)

    if #binned_cards[1] == 2 then
        if #binned_cards[2] == 2 then
            hand = HANDS.TWO_PAIR
        else
            hand = HANDS.PAIR
        end
    end

    if #binned_cards[1] == 3 then
        if #binned_cards[2] == 2 then
            hand = HANDS.FH
        else
            hand = HANDS.THREE_KIND
        end
    end

    if #binned_cards[1] == 4 then
        hand = HANDS.FOUR_KIND
    end

    -- Special hands
    if is_straight(cards) then
        hand = HANDS.STRAIGHT
    end

    if is_flush(cards) then
        hand = HANDS.FLUSH
    end

    if is_flush(cards) and is_straight(cards) then
        hand = HANDS.SFLUSH
    end

    -- royal flush
    if hand == HANDS.SFLUSH and get_num(cards[1]) == 1 then
        hand = HANDS.RFLUSH
    end

    return hand
end


-- Debugging binned cards
function dbg_bin(b)
    local s = ""
    for _, c in pairs(b) do
        local temp = "{"..table.concat(c,",").."} "
        s = s..temp
    end
    return s
end


function p1_wins(cards1, cards2)
    local h1, h2 = get_hand(cards1), get_hand(cards2)
    
    if h1 ~= h2 then
        return h1 > h2
    end
    
    -- tiebreaker
    local b1, b2 = get_binned_cards(cards1), get_binned_cards(cards2)
    for i = 1, #b1 do
        local c1, c2 = b1[i][1], b2[i][1]
        local n1, n2 = get_num(c1), get_num(c2)

        if n1 ~= n2 then
            return n1 > n2
        end
    end

end


function parse_hand(line)
    local p1, p2 = {}, {}
    for c in line:gmatch("%w+") do
        if #p1 < 5 then
            p1[#p1+1] = c
        else
            p2[#p2+1] = c
        end
    end
    return p1, p2
end


function main()
    local p1wins = 0
    for line in io.lines("054.txt") do
        local p1, p2 = parse_hand(line)

        if p1_wins(p1, p2) then
            p1wins = p1wins + 1
        end
    end
    print(p1wins)
end

main()
