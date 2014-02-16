-- Each character on a computer is assigned a unique code and the preferred
-- standard is ASCII (American Standard Code for Information Interchange). For
-- example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.
--
-- A modern encryption method is to take a text file, convert the bytes to ASCII,
-- then XOR each byte with a given value, taken from a secret key. The advantage
--     with the XOR function is that using the same encryption key on the cipher
--     text, restores the plain text; for example, 65 XOR 42 = 107, then 107 XOR
--     42 = 65.
--
-- For unbreakable encryption, the key is the same length as the plain text
--     message, and the key is made up of random bytes. The user would keep the
--     encrypted message and the encryption key in different locations, and
--     without both "halves", it is impossible to decrypt the message.
--
-- Unfortunately, this method is impractical for most users, so the modified
-- method is to use a password as a key. If the password is shorter than the
-- message, which is likely, the key is repeated cyclically throughout the
-- message. The balance for this method is using a sufficiently long password key
-- for security, but short enough to be memorable.
--
-- Your task has been made easy, as the encryption key consists of three lower
-- case characters. Using cipher1.txt (right click and 'Save Link/Target As...'),
-- a file containing the encrypted ASCII codes, and the knowledge that the plain
-- text must contain common English words, decrypt the message and find the sum of
-- the ASCII values in the original text.

WORDS = {}

function load_words(file)
    for l in io.lines(file) do
        WORDS[l] = 1
    end
end


function xor(msg, key)
    local chars = {}
    local i = 1
    for _, c in pairs(msg) do
        local byte = bit32.bxor(c, key[i])
        chars[#chars+1] = string.char(byte)
        i = (i+3)%3 + 1
    end

    return table.concat(chars)
end

function read_file()
    local line
    for l in io.lines("059.txt") do
        line = l
        break
    end

    local chars = {}
    for c in string.gmatch(line, "%d+") do
        chars[#chars+1] = c
    end

    return chars
end


function correct_words(s)
    local correct, incorrect = 0, 0
    for w in string.gmatch(s, "%w+") do
        if WORDS[w] then
            correct = correct + 1
        else
            incorrect = incorrect + 1
        end
    end
    return correct, incorrect
end


function sum_ascii(s)
    local sum = 0
    for i = 1, #s do
        sum = sum + string.byte(s,i)
    end
    return sum
end


function main()
    load_words("/usr/share/dict/cracklib-small")

    local msg = read_file()

    local ascii_start, ascii_end = 97, 122
    for a = ascii_start, ascii_end do
        for b = ascii_start, ascii_end do
            for c = ascii_start, ascii_end do
                local decrypted = xor(msg, {a, b, c})

                local correct, incorrect = correct_words(decrypted)
                if incorrect < 100 then
                    print(sum_ascii(decrypted))
                    return
                end
            end
        end
    end
end

main()
