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
    if number == 1 { return 2; }
    sundaram_sieve(&number).nth((number - 2) as usize).unwrap()
}

/// Output at least `number` prime numbers excluding number 2
fn sundaram_sieve(&number: &u64) -> Box<Iterator<Item=u64>> {
    // the 10_000th number is 104_728
    let limit = (number * 11 - 1) / 2 + 1;
    let count_limit = 100_000;
    let primes = 1..100_000;
    let mut sieve: Vec<u64> = Vec::new();

    for i in 1..count_limit {
        let mut j = i;
        while j < count_limit {
            let n = i + j + 2*i*j;
            if n > limit { break; }
            sieve.push(n);
            j += 1;
        }
    }

    sieve.sort();
    println!("{:?}", sieve.len());
    sieve.dedup();
    println!("{:?}", sieve.len());

    Box::new(
        primes
            .filter(move |p| ! sieve.contains(p))
            .map(|p| p * 2 + 1)
    )
}
