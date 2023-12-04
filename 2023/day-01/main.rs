extern crate regex;

use std::fs::File;
use std::io::{self, BufRead};
use regex::Regex;

fn calc_sum(lines: &Vec<String>, regex: Regex) -> i32 {
    let intify = vec![
        ("one", "1"), ("two", "2"), ("three", "3"), ("four", "4"), ("five", "5"),
        ("six", "6"), ("seven", "7"), ("eight", "8"), ("nine", "9"),
    ];

    lines.iter()
         .filter_map(|line| {
             if let Some(caps) = regex.captures(&line) {
                 let captured: String = [1, 2, 3, 3]
                     .iter()
                     .filter_map(|&i| caps.get(i).map(|m| m.as_str()))
                     .fold(String::new(), |acc, val| acc + val);

                 intify
                     .iter()
                     .fold(captured, |acc, (word, digit)| acc.replace(word, digit))
                     .parse::<i32>().ok()
             } else {
                 None
             }
         })
         .sum()
}

fn main() -> io::Result<()> {
    let input_file = File::open("day-01/input-2023-01.txt")?;
    let lines = io::BufReader::new(input_file)
        .lines()
        .filter_map(|l| l.ok())
        .collect();

    let legal = r"\d|one|two|three|four|five|six|seven|eight|nine";

    let regex1 = Regex::new(&format!(r"^.*?({0}).*({0}).*$|^.*({0}).*$", r"\d")).unwrap();
    let regex2 = Regex::new(&format!(r"^.*?({0}).*({0}).*$|^.*({0}).*$", legal)).unwrap();

    println!("Day 1: {}", calc_sum(&lines, regex1));
    println!("Day 2: {}", calc_sum(&lines, regex2));

    Ok(())
}




// use std::fs::read_to_string;
// use std::collections::HashMap;

// trait Reverse {
//     fn rev(&self) -> String;
// }

// impl Reverse for String {
//     fn rev(&self) -> String {
//         self.chars().rev().collect()
//     }
// }


// fn split_lines(input: &str) -> Vec<String> {
//     input.split("\n")
//          .filter_map(|s| if s.is_empty() { None } else { Some(s.to_string()) } )
//          .collect()
// }


// // Get the positions of each string in valid, then return the one which is smallest
// fn find_first(line: &String, valid: Vec<String>) -> String {
//     valid.iter()
//          .map(|v| line.find(v).map(|idx| (idx, v)))
//          .flatten()
//          .min()
//          .map(|res| res.1)
//          .unwrap()
//          .to_string()
// }


// // Build a from/to mapping of all the legal values
// fn build_mapping() -> HashMap<String, String> {
//     (1..=9)
//         .map(|i| (i.to_string(), i.to_string()))
//         .chain(
//             vec!["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
//                 .iter()
//                 .zip(1..=9)
//                 .map(|(a, b)| (a.to_string(), b.to_string()))
//                 .collect::<Vec<(String, String)>>()
//         )
//         .collect()
// }


// // Find the first digit,
// // then reverse everything and find the first (last)
// fn extract_number(line: &String, valid: &HashMap<String, String>) -> i32 {
//     let valid_keys: Vec<_> = valid.keys().map(|k| k.to_string()).collect();
//     let rev_keys = valid_keys.iter().map(|k| k.rev()).collect();

//     let first = find_first(line, valid_keys);
//     let last = find_first(&line.rev(), rev_keys);

//     let first_digit = valid.get(first.as_str()).unwrap();
//     let last_digit = valid.get(last.rev().as_str()).unwrap();

//     let num = first_digit.to_owned() + last_digit;
//     num.parse::<i32>().unwrap()
// }


// fn main() {
//     // Read the file
//     let contents = read_to_string("./day-01/input-2023-01.txt").expect("File not found");

//     // Split into lines
//     let lines = split_lines(&contents);

//     // Build mapping of valid numbers
//     let valid_pt1 = (1..=9).map(|i| (i.to_string(), i.to_string())).collect();
//     let valid_pt2 = build_mapping();

//     // Extract numbers and build into sum
//     let sum_pt1: i32 = lines.iter()
//                         .map(|l| extract_number(l, &valid_pt1))
//                         .sum();

//     let sum_pt2: i32 = lines.iter()
//                         .map(|l| extract_number(l, &valid_pt2))
//                         .sum();

//     println!("{}", sum_pt1);
//     println!("{}", sum_pt2);
// }
