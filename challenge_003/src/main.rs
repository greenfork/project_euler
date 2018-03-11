use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: u64 = number.trim_right().parse().unwrap();

        println!("{}", find_greatest_prime_factor(number));
    }
}

fn find_greatest_prime_factor(number: u64) -> u64 {
    let mut temp_number = number;

    divide_and_conquer(&mut temp_number, 2);
    if temp_number == 1 { return 2; }

    let upper_limit = (temp_number as f64).sqrt().ceil() as u64;

    let mut i = 1;
    while temp_number != 1 {
        i += 2;
        if i > upper_limit { return temp_number }
        divide_and_conquer(&mut temp_number, i);
    }
    i
}

fn divide_and_conquer(number: &mut u64, divider: u64) {
    while *number % divider == 0 {
        *number /= divider;
    }
}
