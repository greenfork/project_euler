use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: u64 = number.trim_right().parse().unwrap();

        println!("{}", find_palindrome(&number));
    }
}

fn find_palindrome(&number: &u64) -> u64 {
    for a in (1..10).rev() {
        for b in (0..10).rev() {
            for c in (0..10).rev() {
                // pre_palindrome * 11 = full palindrome
                let pre_palindrome = a * 9091 + b * 910 + c * 100;

                if pre_palindrome * 11 < number &&
                    is_divisible(&pre_palindrome)
                {
                    return pre_palindrome * 11;
                }
            }
        }
    }
    0
}

fn is_divisible(&number: &u64) -> bool {
    for i in (100..1000).rev() {
        if number % i == 0 && (number * 11 / i).to_string().len() == 3 {
            return true;
        }
    }
    false
}
