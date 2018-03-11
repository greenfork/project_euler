use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: u64 = number.trim_right().parse().unwrap();

        println!("{}", pythagorean_triplet(&number));
    }
}

fn pythagorean_triplet(&number: &u64) -> i64 {
    if number % 2 != 0 {
        return -1;
    }

    let mut triplets = Vec::new();

    for a in 1..(number + 1) {
        let mut b = a;
        while b < number {
            b += 1;

            if number < a + b || number - a - b < b {
                break;
            }

            let mut c = number - a - b;
            if is_triplet(a, b, c) {
                triplets.push((a, b, c));
            }
        }
    }

    largest_product(triplets)
}

fn is_triplet(a: u64, b: u64, c: u64) -> bool {
    a * a + b * b == c * c
}

fn largest_product(variants: Vec<(u64, u64, u64)>) -> i64 {
    let mut max_product = 0;
    for (a, b, c) in variants {
        let product = a * b * c;
        if product > max_product {
            max_product = product;
        }
    }
    if max_product != 0 {
        max_product as i64
    } else {
        -1
    }
}
