//A palindromic number reads the same both ways. The largest palindrome made
//from the product of two 2-digit numbers is 9009 = 91 × 99.
//
//Find the largest palindrome made from the product of two 3-digit numbers.


fn is_palindrome(s: &str) -> bool {
    let len = s.char_len();
    let mut a = 0;
    let mut b = len - 1;

    while a < b {
        if s[a] != s[b] {
            return false;
        }
        a += 1;
        b -= 1;
    }
    return true;
}

fn get_palindromes(start: uint, finish: uint) -> uint {
    let mut max = 0;
    for i in range(start, finish + 1) {
        for j in range(i, finish + 1) {
            let prod = i * j;
            if prod > max && is_palindrome(format!("{}", prod)) {
                max = prod;
            }
        }
    }
    return max;
}

fn main(){
    println!("{}", get_palindromes(900,1000));
}
