use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: f64 = number.trim_right().parse().unwrap();

        let result = ((number + 1.0) * number / 2.0).powi(2) -
            number * (number + 1.0) * (2.0 * number + 1.0) / 6.0;
        println!("{}", result);
    }
}
