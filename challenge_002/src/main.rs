use std::io;

fn main() {
    let mut q = String::new();
    io::stdin().read_line(&mut q).unwrap();
    let q: usize = q.trim_right().parse().unwrap();

    for _ in 0..q {
        let mut number = String::new();
        io::stdin().read_line(&mut number).unwrap();
        let number: u64 = number.trim_right().parse().unwrap();
        let mut sum: u64 = 0;

        let mut fibonacci = fibonacci();
        loop {
            if let Some(n) = fibonacci.next() {
                if n > number { break; }
                if n % 2 == 0 { sum += n; }
            }
        }
        println!("{}", sum);
    }
}

fn fibonacci() -> Fibonacci {
    Fibonacci { curr: 1, next: 1 }
}

struct Fibonacci {
    curr: u64,
    next: u64,
}

impl Iterator for Fibonacci {
    type Item = u64;

    fn next(&mut self) -> Option<u64> {
        let res = self.curr + self.next;
        self.curr = self.next;
        self.next = res;
        Some(res)
    }
}
