extern crate regex;

use std::fs::read_to_string;
use regex::Regex;

const LINE_LEN: usize = 141;
const NUM_LINES: usize = 140;
const INPUT_FILE: &str = "./day-03/input-2023-03.txt";


#[derive(Debug)]
struct Symbol {
    symbol_char: String,
    pos: usize,
    part_ids: Vec<usize>
}

#[derive(Debug)]
struct PartLabel {
    part_id: usize,
    pos_start: usize,
    pos_end: usize
}

fn parse_labels(input: &String) -> Vec<PartLabel> {
    Regex::new(r"\d{1,3}")
        .unwrap()
        .find_iter(&input)
        .map(|part| {
            PartLabel {
                part_id: (&input[part.start()..part.end()]).parse::<usize>().unwrap(),
                pos_start: part.start(),
                pos_end: part.end()
            }
        })
        .collect()
}

fn parse_symbols(input: &String) -> Vec<Symbol> {
    Regex::new(r"[#%&*+/=@$-]")
        .unwrap()
        .find_iter(&input)
        .map(|symbol| {
            Symbol {
                symbol_char: input[symbol.start()..symbol.end()].to_string(),
                pos: symbol.start(),
                part_ids: Vec::new()
            }
        })
        .collect()    
}

fn valid_neighbour_coords(pos: usize) -> Vec<usize> {
    let is_start_of_line = pos % LINE_LEN == 0;
    let is_end_of_line = pos % LINE_LEN == LINE_LEN - 1;
    let is_first_line = pos <= LINE_LEN;
    let is_last_line = pos >= LINE_LEN * (NUM_LINES - 1);

    let binding = [
        // Up-Left diagonal
        (!is_first_line && !is_start_of_line).then(|| pos.checked_sub(LINE_LEN + 1)),
        // Up
        (!is_first_line).then(|| pos.checked_sub(LINE_LEN)),
        // Up-Right diagonal
        (!is_first_line && !is_end_of_line).then(|| pos.checked_sub(LINE_LEN - 1)),
        // Left
        (!is_start_of_line).then(|| pos.checked_sub(1)),
        // Right
        (!is_end_of_line).then(|| pos.checked_add(1)),
        // Down-Left diagonal
        (!is_last_line && !is_start_of_line).then(|| pos.checked_add(LINE_LEN - 1)),
        // Down
        (!is_last_line).then(|| pos.checked_add(LINE_LEN)),
        // Down-Right diagonal
        (!is_last_line && !is_end_of_line).then(|| pos.checked_add(LINE_LEN + 1)),
    ];

    binding.iter().filter_map(|coord| coord.flatten()).collect()
}


fn label_symbols(part_labels: &Vec<PartLabel>, symbols: &mut Vec<Symbol>) {
    part_labels
        .iter()
        .for_each(|part_label| {
            let neighbours: Vec<usize> = (part_label.pos_start..part_label.pos_end)
                .flat_map(|idx| valid_neighbour_coords(idx))
                .collect();

            symbols.iter_mut()
                   .filter(|s| neighbours.contains(&s.pos) && !s.part_ids.contains(&part_label.part_id))
                   .for_each(|symbol| symbol.part_ids.push(part_label.part_id));
        });
}


fn main() {
    let input: String = read_to_string(INPUT_FILE).expect("File not found");

    let part_labels = parse_labels(&input);
    let mut symbols = parse_symbols(&input);
    
    label_symbols(&part_labels, &mut symbols);

    let part1: usize = symbols
        .iter()
        .flat_map(|s| s.part_ids.clone())
        .sum();

    // Seems like I don't actually need to filter on symbol = "*" for my input.
    // But doing it anyway as it was specified in the question...
    let part2: usize = symbols
        .iter()
        .filter_map(|s| {
            if s.part_ids.len() == 2 && s.symbol_char == "*" {
                Some(s.part_ids[0] * s.part_ids[1])
            } else {
                None
            }
        })
        .sum();

    println!("Part 1: {}", part1); // Answer: 512794
    println!("Part 2: {}", part2); // Answer: less than 67779080
}
