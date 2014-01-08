-- You are given the following information, but you may prefer to do some research
-- for yourself.
-- 
--     1 Jan 1900 was a Monday.
--     Thirty days has September,
--     April, June and November.
--     All the rest have thirty-one,
--     Saving February alone,
--     Which has twenty-eight, rain or shine.
--     And on leap years, twenty-nine.
--     A leap year occurs on any year evenly divisible by 4, but not on a century
--     unless it is divisible by 400.
-- 
-- How many Sundays fell on the first of the month during the twentieth century (1
-- Jan 1901 to 31 Dec 2000)?
-- 

function is_leap_year(year)
    return year%400 == 0 or (year%4 == 0 and year%100 ~= 0)
end

MONTHS = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

function main()
    local num_sundays = 0

    -- offset = number of days from monday
    -- 1901 starts on a tuesday
    local offset = 2

    for y=1901,2000 do
        local days = 0
        for i=1,12 do
            -- is sunday!
            if (days + offset)%7 == 0 then
                num_sundays = num_sundays + 1
            end

            days = days + MONTHS[i]
            
            -- feb and leap year
            if (is_leap_year(y) and i == 2) then
                days = days + 1
            end
        end
        offset = (offset + days)%7
    end
    print(num_sundays)
end

main()
