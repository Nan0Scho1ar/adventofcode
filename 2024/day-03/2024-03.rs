use std::fs::read_to_string;
use regex::Regex;

const INPUT_FILE: &str = "2024/day-03/input-2024-03.txt";

fn mul(input: &str) -> i32 {
    let re = Regex::new(r"mul\((\d+),(\d+)\)").unwrap();
    re.captures_iter(&input)
      .map(|c| c.extract())
      .map(|(_, [a, b])| a.parse::<i32>().unwrap() * b.parse::<i32>().unwrap())
      .sum()
}

fn main() {
    let text = read_to_string(INPUT_FILE).expect("File not found");
    let clean_text = Regex::new(r"(?s)don't\(\).*?do\(\)")
        .unwrap()
        .replace_all(&text, "");

    println!("Part 1: {:#?}", mul(&text));
    println!("Part 2: {:#?}", mul(&clean_text));
}
