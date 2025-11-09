mod grid { include!("../../libs/rust/grid.rs"); } 
mod parse { include!("../../libs/rust/parse.rs"); } 

use std::fs::read_to_string;
use grid::{Direction, Grid};
use parse::interspace_chars;
use std::collections::HashSet;

const INPUT_FILE: &str = "2024/day-06/input-2024-06.txt";

fn part1(split_text: &str) -> usize {
    let mut grid: Grid<char> = Grid::parse(split_text).unwrap();
    let (x, y) = grid.find('^').unwrap();
    grid.set_pos(x, y);
    grid.set_current('X');

    loop {
        match grid.foward() {
            Some('#') => {
                grid.backward();
                grid.turn(90);
            },
            Some(_) => grid.set_current('X'),
            None => break
        }
    }
    grid.grid.into_iter().filter(|c| c == &'X').collect::<Vec<_>>().len()
}

fn part2(split_text: &str) -> usize {
    let mut cycle_count = 0;
    let mut states: HashSet<(usize, usize, Direction)> = HashSet::new();

    let mut grid: Grid<char> = Grid::parse(split_text).unwrap();
    let cols = grid.cols;
    let rows = grid.rows;
    let (start_x, start_y) = grid.find('^').unwrap();

    for i in 0..cols {
        for j in 0..rows {
            states = HashSet::new();
            grid = Grid::parse(split_text).unwrap();
            grid.set_pos(start_x, start_y);
            grid.set_value(i, j, '#');

            loop {
                match grid.foward() {
                    Some('#') => {
                        grid.backward();
                        grid.turn(90);
                    },
                    Some(_) => {
                        if states.contains(&(grid.x, grid.y, grid.facing)) {
                            cycle_count += 1;
                            break
                        } else {
                            states.insert((grid.x, grid.y, grid.facing));
                        }
                    },
                    None => break,
                }
            }
        }
    }
    cycle_count
}

fn main() {
    let text = read_to_string(INPUT_FILE).expect("File not found");
    let split_text = interspace_chars(&text, " ");

    println!("Part 1: {}", part1(&split_text));
    println!("Part 2: {}", part2(&split_text));

}