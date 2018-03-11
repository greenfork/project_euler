use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: u64 = number.trim_right().parse().unwrap();

        println!("{}", smallest_multiple(&number));
    }
}

fn smallest_multiple(&number: &u64) -> u64 {
    if number == 1 { return 1; }
    let mut prime_factors = vec![2];
    prime_factors.append(&mut sundaram_sieve(&number));
    let mut multiple = prime_factors.iter().product();

    for n in 1..(number + 1) {
        multiple *= is_power(&n, &prime_factors);
    }

    multiple
}

/// If the number is a power of a prime, output this prime; output 1 otherwise
fn is_power(&number: &u64, vec: &Vec<u64>) -> u64 {
    let upper_limit = (number as f64).sqrt().ceil() as u64;

    for &v in vec {
        if v > upper_limit || v == number { break; }
        if number % v == 0 {
            let mut n = number;
            while n % v == 0 { n /= v; }
            if n == 1 { return v; }
        }
    }

    1
}

fn sundaram_sieve(&number: &u64) -> Vec<u64> {
    let upper_limit = (number - 1) / 2 + 1;
    let primes: Vec<u64> = (1..upper_limit).collect();
    let mut sieve: Vec<u64> = Vec::new();

    for i in 1..upper_limit {
        for j in 1..upper_limit {
            let n = i + j + 2*i*j;
            if n > number { break; }
            sieve.push(n);
        }
    }

    sieve.sort();
    sieve.dedup();

    primes
        .iter()
        .filter(|&p| ! &sieve.contains(p))
        .map(|p| 2 * p + 1)
        .collect::<Vec<u64>>()
}
