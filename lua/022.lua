-- Using names.txt (right click and 'Save Link/Target As...'), a 46K text file
-- containing over five-thousand first names, begin by sorting it into
-- alphabetical order. Then working out the alphabetical value for each name,
-- multiply this value by its alphabetical position in the list to obtain a name
-- score.
-- 
-- For example, when the list is sorted into alphabetical order, COLIN, which is
--     worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN
--     would obtain a score of 938 × 53 = 49714.
-- 
-- What is the total of all the name scores in the file?

-- create {A=1,B=2,...}
function create_alphabet_table()
    local t = {}
    for i=1,26 do
        t[string.char(i+64)] = i
    end
    return t
end

function create_names_table()
    local t = {}
    for i=1,26 do t[i] = {} end
    return t
end

ALPHABET_TABLE = create_alphabet_table()

function get_score(s)
    local score = 0
    for i=1,#s do
        score = score + ALPHABET_TABLE[string.sub(s,i,i)]
    end
    return score
end

function read_names(filename)
    local names_table = {}
    for line in io.lines(filename) do
        for name in string.gmatch(line, "%w+") do
            names_table[#names_table+1] = name
        end
    end
    return names_table
end


function main()
    local names = read_names("022.txt")
    table.sort(names)

    local sum = 0
    for i=1,#names do
        local score = i * get_score(names[i])
        sum = sum + score
    end
    print(sum)
end

main()
