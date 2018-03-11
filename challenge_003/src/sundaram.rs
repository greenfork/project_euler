use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: u64 = number.trim_right().parse().unwrap();
        let mut result = 0;

        let primes = sieve_of_sundaram(number);
        for &p in primes.iter().rev() {
            if number % p == 0 {
                result = p;
                break;
            }
        }

        println!("{}", result);
    }
}

/// Get the prime numbers up to `limit`
fn sieve_of_sundaram(limit: u64) -> Vec<u64> {
    let upper_limit: u64 = (limit - 1) / 2 + 1;
    let pre_primes: Vec<u64> = (1..upper_limit).collect::<Vec<u64>>();
    let mut remove: Vec<u64> = Vec::new();

    for i in 1..upper_limit {
        for j in 1..upper_limit {
            let expr = i + j + 2 * i * j;
            if expr > upper_limit { break; }
            remove.push(expr);
        }
    }

    remove.sort();
    remove.dedup();

    pre_primes
        .iter()
        .filter(|&p| ! &remove.contains(p))
        .map(|p| 2 * p + 1)
        .collect::<Vec<u64>>()
}
