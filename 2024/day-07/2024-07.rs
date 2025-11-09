use std::fs::read_to_string;

const INPUT_FILE: &str = "2024/day-07/sample-2024-07.txt";

struct Equation {
    target: usize,
    fragments: Vec<usize>
}

impl Equation {
    pub fn parse(input: &str) -> Self {
        let chunks: Vec<_> = input.split(":").collect();
        let target: usize = chunks[0].parse::<usize>().unwrap();

    }
}

fn main() {
    let text = read_to_string(INPUT_FILE).expect("File not found");
    let equations: Vec<Equation> = text.lines()
        .map(|line| Equation::parse(line))
        .collect();

    dbg!(text);
}