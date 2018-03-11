use std::io;

fn main() {
    let mut grid = [[0; 20]; 20];
    for i in 0..20 {
        let mut line = String::new();
        io::stdin().read_line(&mut line).unwrap();
        let mut line = line.trim_right().split_whitespace();

        for j in 0..20 {
            grid[i][j] = line.next().unwrap().parse().unwrap();
        }
    }

    println!("{}", largest_product_in_grid(grid));
}

fn largest_product_in_grid(grid: [[u32; 20]; 20]) -> u32 {
    let updown = largest_updown(&grid);
    let leftright = largest_leftright(&grid);
    let diagonal = largest_diagonal(&grid);

    *[updown, leftright, diagonal].iter().max().unwrap()
}

fn largest_updown(&grid: &[[u32; 20]; 20]) -> u32 {
    let mut max_product = 0;
    for i in 0..17 {
        for j in 0..20 {
            let product = updown(&grid, (i, j));
            if product > max_product {
                max_product = product;
            }
        }
    }
    max_product
}

fn updown(&grid: &[[u32; 20]; 20], (i, j): (usize, usize)) -> u32 {
    grid[i][j] * grid[i+1][j] * grid[i+2][j] * grid[i+3][j]
}

fn largest_leftright(&grid: &[[u32; 20]; 20]) -> u32 {
    let mut max_product = 0;
    for i in 0..20 {
        for j in 0..17 {
            let product = leftright(&grid, (i, j));
            if product > max_product {
                max_product = product;
            }
        }
    }
    max_product
}

fn leftright(&grid: &[[u32; 20]; 20], (i, j): (usize, usize)) -> u32 {
    grid[i][j] * grid[i][j+1] * grid[i][j+2] * grid[i][j+3]
}

fn largest_diagonal(&grid: &[[u32; 20]; 20]) -> u32 {
    let mut max_product = 0;
    for i in 0..17 {
        for j in 0..17 {
            let product = diagonal_prime(&grid, (i, j));
            if product > max_product {
                max_product = product;
            }
        }
    }
    for i in 3..20 {
        for j in 0..17 {
            let product = diagonal_secondary(&grid, (i, j));
            if product > max_product {
                max_product = product;
            }
        }
    }
    max_product
}

fn diagonal_prime(&grid: &[[u32; 20]; 20], (i, j): (usize, usize)) -> u32 {
    grid[i][j] * grid[i+1][j+1] * grid[i+2][j+2] * grid[i+3][j+3]
}

fn diagonal_secondary(&grid: &[[u32; 20]; 20], (i, j): (usize, usize)) -> u32 {
    grid[i][j] * grid[i-1][j+1] * grid[i-2][j+2] * grid[i-3][j+3]
}
