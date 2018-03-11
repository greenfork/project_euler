use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: u64 = number.trim_right().parse().unwrap();

        println!("{}", nth_prime(&number));
    }
}

fn nth_prime(&number: &u64) -> u64 {
    let mut n = 0;
    let primes = eratosthenes_sieve_150_000();
    let mut i = 0;

    while n < number {
        i += 1;
        if primes[i] {
            n += 1;
        }
    }

    i as u64
}

fn eratosthenes_sieve_150_000() -> [bool; 150_000] {
    let mut primes = [true; 150_000];
    primes[0] = false;
    primes[1] = false;
    let length = primes.len();
    let sqrt = (length as f64).sqrt() as usize;

    let mut i = 4;
    while i < length {
        primes[i] = false;
        i += 2;
    }

    let mut p = 3;
    while p < sqrt + 1 {
        if primes[p] {
            i = p * p;
            while i < length {
                primes[i] = false;
                i += 2 * p;
            }
        }
        p += 2;
    }

    primes
}
