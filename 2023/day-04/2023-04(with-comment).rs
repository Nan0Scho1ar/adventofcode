extern crate fancy_regex;

use std::fs::read_to_string;
use fancy_regex::Regex;

const INPUT_FILE: &str = "./2023/day-04/input-2023-04.txt";
const NUM_CARDS: usize = 197;

fn main() {
    let re = Regex::new(r"\b(\d+)\b(?!:)(?=.*?\|.*?\b\1\b)").unwrap();

    let (part1, part2, _) = read_to_string(INPUT_FILE)
        .unwrap()
        .lines()
        // Count how many numbers match in each card. This is the "score" for that card.
        .map(|line| re.captures_iter(line).count())
        .enumerate()
        // Init running totals to 0 and the card counts with 1 of each card.
        .fold((0, 0, vec![1; NUM_CARDS]), |(mut pt1, mut pt2, mut counts), (idx, score)| {
            // Part1: Score is 2^(n-1) where n is match count. Add it to the running total.
            pt1 += score.checked_sub(1).map_or(0, |len| 2u32.pow(len as u32));
            // Part2: Add the count of this card to the running total.
            pt2 += counts[idx];
            // Update the card counts of the following cards based on this one.
            (idx+1..=idx+score).for_each(|c| counts[c] += counts[idx]);
            //Pass accumulators through to next iteration to process the next card.
            (pt1, pt2, counts)
        });

    println!("Part 1: {}", part1);
    println!("Part 2: {}", part2);
}
