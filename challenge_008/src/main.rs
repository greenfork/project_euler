use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut string = String::new();
        let mut number = String::new();
        io::stdin().read_line(&mut string).unwrap();
        io::stdin().read_line(&mut number).unwrap();
        let mut string = string.trim_right().split_whitespace();
        let _digits_l: u64 = string.next().unwrap().parse().unwrap();
        let series_l: u64 = string.next().unwrap().parse().unwrap();
        let number = number.trim_right();

        println!("{}", largest_product(&series_l, number));
    }
}

fn largest_product(&series_l: &u64, number: &str) -> u64 {
    let digits: Vec<u64> = number
        .chars()
        .map(|c| c.to_digit(10).expect("to digit") as u64)
        .collect();
    let mut windows = digits.windows(series_l as usize);
    let mut max_product: u64 = 0;
    if let Some(n) = windows.next() {
        max_product = n.iter().product::<u64>();
    }

    for n in windows {
        let product = n.iter().product();
        if product > max_product {
            max_product = product;
        }
    }

    max_product
}
