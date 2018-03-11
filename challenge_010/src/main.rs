use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: u64 = number.trim_right().parse().unwrap();

        println!("{}", sum_of_primes(&number));
    }
}

fn sum_of_primes(&number: &u64) -> u64 {
    let sieve = sieve_1_000_001();
    let mut sum = 2;

    let mut i: usize = 3;
    while i < number as usize + 1 {
        if sieve[i] {
            sum += i;
        }
        i += 2;
    }
    sum as u64
}

fn sieve_1_000_001() -> [bool; 1_000_001] {
    let mut primes = [true; 1_000_001];
    primes[0] = false;
    primes[1] = false;
    let length = primes.len();
    let sqrt = (length as f64).sqrt() as usize;

    let mut i = 4;
    while i < length {
        primes[i] = false;
        i += 2;
    }

    i = 3;
    while i < sqrt + 1 {
        if primes[i] {
            let mut p = i * i;
            while p < length {
                primes[p] = false;
                p += 2 * i;
            }
        }
        i += 2;
    }

    primes
}
