-- The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); so
-- the first ten triangle numbers are:
--
-- 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
--
-- By converting each letter in a word to a number corresponding to its
-- alphabetical position and adding these values we form a word value. For
-- example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value
-- is a triangle number then we shall call the word a triangle word.
--
-- Using words.txt (right click and 'Save Link/Target As...'), a 16K text file
-- containing nearly two-thousand common English words, how many are triangle
-- words?

FILENAME = "042.txt"

function get_tval(n)
    return n*(n+1)/2
end


function get_word_val(word)
    local val = 0
    for i=1,#word do
        val = val + string.byte(word,i) - 64
    end

    return val
end


function load_words()
    local line
    -- get first line
    for l in io.lines(FILENAME) do
        line = l
    end

    local words = {}
    for w in string.gmatch(line, "%S+") do
        words[#words+1] = w
    end

    return words
end


function main()
    local words = load_words()

    -- find max word length
    local max_len = 0
    for _, w in pairs(words) do
        if #w > max_len then
            max_len = #w
        end
    end

    local tri_nums, i = {}, 1
    while get_tval(i) < max_len * 26 do
        tri_nums[get_tval(i)] = 1
        i = i + 1
    end

    -- how many triangle words?
    local num = 0
    for _, w in pairs(words) do
        if tri_nums[get_word_val(w)] then
            num = num + 1
        end
    end

    print(num)
end

main()
