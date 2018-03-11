use std::io;

fn main() {
    let mut queries = String::new();
    io::stdin().read_line(&mut queries).unwrap();
    let queries: usize = queries.trim_right().parse().unwrap();

    for _ in 0..queries {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: usize = number.trim_right().parse().unwrap();
        let mut div_three = number as i64 / 3;
        let mut div_five = number as i64 / 5;
        let mut div_fifteen = number as i64 / 15;

        if number % 3 == 0 { div_three -= 1 }
        if number % 5 == 0 { div_five -= 1 }
        if number % 15 == 0 { div_fifteen -= 1 }

        let sum = multipliers_sum(3, div_three as usize) +
            multipliers_sum(5, div_five as usize) -
            multipliers_sum(15, div_fifteen as usize);

        println!("{}", sum);
    }
}

fn multipliers_sum(number: i64, count: usize) -> i64 {
    let mut sum = 0;
    for i in 0..count {
        sum += number * (i + 1) as i64;
    }
    sum
}
