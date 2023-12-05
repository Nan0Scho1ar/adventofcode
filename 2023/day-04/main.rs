extern crate fancy_regex;

use std::fs::read_to_string;
use fancy_regex::Regex;

const INPUT_FILE: &str = "./day-04/input-2023-04.txt";
const NUM_CARDS: usize = 197;

fn main() {
    let re = Regex::new(r"\b(\d+)\b(?!:)(?=.*?\|.*?\b\1\b)").unwrap();

    let (part1, part2, _) = read_to_string(INPUT_FILE)
        .unwrap()
        .lines()
        .map(|line| re.captures_iter(line).count())
        .enumerate()
        .fold((0, 0, vec![1; NUM_CARDS]), |(mut pt1, mut pt2, mut counts), (idx, score)| {
            pt1 += score.checked_sub(1).map_or(0, |len| 2u32.pow(len as u32));
            pt2 += counts[idx];
            (idx+1..=idx+score).for_each(|c| counts[c] += counts[idx]);
            (pt1, pt2, counts)
        });

    println!("Part 1: {}", part1);
    println!("Part 2: {}", part2);
}
