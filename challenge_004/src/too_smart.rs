use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: u64 = number.trim_right().parse().unwrap();

        println!("{:?}", permut(&number));
    }
}

fn greatest_palindrome(mut number: u64) -> u64 {
    // Every 6-digit palindromic number is divisible by 11
    while number % 11 != 0 { number -= 1; }
    while ! is_palindrome(&number) && ! is_product(&number) {
        number -= 11;
    }
    number
}

/// Checks whether a number is a palindrome; only for 6-digit numbers
fn is_palindrome(&number: &u64) -> bool {
    let str_number = number.to_string().chars().collect::<Vec<char>>();
    assert_eq!(6, str_number.len());

    if str_number[0] == str_number[5] &&
        str_number[1] == str_number[4] &&
        str_number[2] == str_number[3]
    {
        true
    } else {
        false
    }
}

/// Checks whether a number can be written as a product of two 3-digit numbers
fn is_product(number: &u64) -> bool {
    let permutations = permut(number);

    true
}

fn has_3digits(&number: &u64) -> bool {
    number.to_string().len() == 3
}

/// Finds all permutations using generation in the lexicographic order
fn permut(&number: &u64) -> Vec<Vec<u64>> {
    let mut prime_factors = prime_factors(&number);
    prime_factors.sort();
    let length = prime_factors.len();
    let perm_count = factorial(&(length as u64)) as usize;
    let mut permutations: Vec<Vec<u64>> = Vec::new();
    permutations.push(prime_factors);

    for perm_no in 0..perm_count {
        let mut k = 0;
        for i in (1..length).rev() {
            if permutations[perm_no][i - 1] < permutations[perm_no][i] {
                k = i - 1;
                break;
            }
        }

        let mut l = 0;
        for i in (k..length).rev() {
            if permutations[perm_no][k] < permutations[perm_no][i] {
                l = i;
                break;
            }
        }

        println!("{} {}", k, l);
        let perm = permutations[perm_no].clone();
        permutations.push(perm);
        permutations[perm_no + 1][k] = permutations[perm_no][l];
        permutations[perm_no + 1][l] = permutations[perm_no][k];
    }

    permutations
}

fn factorial(&n: &u64) -> u64 {
    if n == 1 { return n; }
    factorial(&(n - 1)) * n
}

/// Decompose a number in its prime factors using Pollard's rho algorithm
fn prime_factors(number: &u64) -> Vec<u64> {
    let mut prime_factors: Vec<u64> = Vec::new();
    // Since it's divisible by 11
    let mut number = *number / 11;
    prime_factors.push(11);

    let mut x = 2;
    let mut y = 2;
    let mut factor = 1;
    let mut tries = 5;
    // arrays for changing input in case of a failure
    let x_arr = [1, 2, 3, 4, 5];
    let y_arr = [5, 4, 3, 2, 1];

    while tries > 0 {
        while factor == 1 {
            x = g(&x, &number);
            y = g(&g(&y, &number), &number);
            factor = gcd(&((x as i64 - y as i64).abs() as u64), &number);
        }
        if factor == number {
            tries -= 1;
            x = x_arr[tries];
            y = y_arr[tries];
            if tries == 0 { prime_factors.push(factor); }
            factor = 1;
        } else {
            prime_factors.push(factor);
            number /= factor;
            x = 2;
            y = 2;
            factor = 1;
        }
    }

    prime_factors
}

/// Used in Polland's rho algorithm
fn g(&x: &u64, &number: &u64) -> u64 {
    (x * x + 1) % number
}

fn gcd(&num1: &u64, &num2: &u64) -> u64 {
    let mut a;
    let mut b;
    let mut remainder;
    if num1 > num2 {
        a = num1;
        b = num2;
    } else {
        a = num2;
        b = num1;
    }

    while b != 0 {
        remainder = a % b;
        a = b;
        b = remainder;
    }
    a
}
