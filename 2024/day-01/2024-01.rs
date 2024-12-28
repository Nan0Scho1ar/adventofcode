use std::fs::read_to_string;
use itertools::Itertools;

const INPUT_FILE: &str = "2024/day-01/input-2024-01.txt";

fn main() {
    let text = read_to_string(INPUT_FILE).expect("File not found");
    let (mut a, mut b): (Vec<_>, Vec<_>) = text
        .lines()
        .map(|l|
             l.split_whitespace()
             .map(|s| s.parse::<i32>().unwrap())
             .collect_tuple()
             .unwrap()
        )
        .unzip();

    a.sort();
    b.sort();

    let part1: i32 = a.iter()
                      .zip(&b)
                      .map(|(a, b)| (a - b).abs())
                      .sum();


    let part2: i32 = a.iter()
                      .flat_map(|&a| b.iter().map(move |&b| if a == b {a} else {0})).sum();

    println!("{:#?}", part1);
    println!("{:#?}", part2);
}
