-- 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
-- 
-- What is the sum of the digits of the number 2^1000?

num = math.pow(2,1000)
s = string.format("%f",num)
print(s)

sum = 0
for i=1,string.find(s,".",1,true)-1 do
    sum = sum + tonumber(string.sub(s,i,i))
end

print(sum)
