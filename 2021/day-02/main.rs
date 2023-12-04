use std::fs::read_to_string;

#[derive(Debug, PartialEq)]
enum Cmd {
    Forward,
    Up,
    Down
}

fn main() {
    let contents = read_to_string("./day-02/input-2023-02.txt").expect("File not found");

    let commands: Vec<(Cmd, i32)> = contents
        .split("\n")
        .filter_map(|s| {
            match s.split_whitespace().collect::<Vec<&str>>()[..] {
                ["up", num] => Some((Cmd::Up, num.parse::<i32>().unwrap())),
                ["down", num] => Some((Cmd::Down, num.parse::<i32>().unwrap())),
                ["forward", num] => Some((Cmd::Forward, num.parse::<i32>().unwrap())),
                _ => None
            }
        })
        .collect();
    dbg!(commands);

    // println!("Part 1: {}", contents);
}
