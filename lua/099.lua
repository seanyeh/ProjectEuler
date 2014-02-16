-- Comparing two numbers written in index form like 211 and 37 is not difficult,
-- as any calculator would confirm that 211 = 2048 < 37 = 2187.
--
-- However, confirming that 632382518061 > 519432525806 would be much more
-- difficult, as both numbers contain over three million digits.
--
-- Using base_exp.txt (right click and 'Save Link/Target As...'), a 22K text file
-- containing one thousand lines with a base/exponent pair on each line, determine
-- which line number has the greatest numerical value.
--
-- NOTE: The first two lines in the file represent the numbers in the example
-- given above.


function main()
    local max, line_num = 0, 0
    local i = 1
    for line in io.lines("099.txt") do
        for a, b in string.gmatch(line, "(%d+),(%d+)") do
            temp = math.log(a) * b
            if temp > max then
                max = temp
                line_num = i
            end
        end
        i = i + 1
    end

    print(line_num)
end

main()
