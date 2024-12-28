use std::fs::read_to_string;

const INPUT_FILE: &str = "2024/day-02/input-2024-02.txt";

fn safe(report: &[i32]) -> bool {
    let deltas: Vec<i32> = report.iter()
            .zip(report.iter().skip(1))
            .map(|(a,b)| b - a)
            .collect();
    let less_than_4 = deltas.iter().all(|d| d.abs() < 4);
    let all_negative = deltas.iter().all(|d| *d < 0);
    let all_positive = deltas.iter().all(|d| *d > 0);
    less_than_4 && (all_negative || all_positive)
}

fn dampened(report: &[i32]) -> bool {
    (0..report.len())
        .map(|i| {
            report.iter()
                .enumerate()
                .filter(|&(idx, _)| idx != i)
                .map(|(_, &val)| val)
                .collect::<Vec<i32>>()
        })
        .map(|i| safe(&i))
        .any(|r| r)
}

fn main() {
    let text = read_to_string(INPUT_FILE).expect("File not found");
    let ints: Vec<Vec<i32>> = text
        .lines()
        .map(|l|
             l.split_whitespace()
             .map(|s| s.parse::<i32>().unwrap())
             .collect()
        )
        .collect();

    let part1 = ints.iter().filter(|i| safe(i)).collect::<Vec<_>>().len();
    let part2 = ints.iter().filter(|i| dampened(i)).collect::<Vec<_>>().len();

    println!("Part 1: {:#?}", part1);
    println!("Part 2: {:#?}", part2);
}
