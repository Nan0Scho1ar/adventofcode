use std::fs::read_to_string;

const MAX_RED: i32 = 12;
const MAX_GREEN: i32 = 13;
const MAX_BLUE: i32 = 14;

const INPUT_FILE: &str = "./2023/day-02/input-2023-02.txt";

struct Round {
    red: i32,
    green: i32,
    blue: i32
}

struct Game {
    id: i32,
    rounds: Vec<Round>
}


impl Game {
    fn is_possible(&self) -> bool {
       self.rounds.iter().all(|round| round.red <= MAX_RED
                              && round.green <= MAX_GREEN
                              && round.blue <= MAX_BLUE) 
    }

    fn min_cubes_required(&self) -> i32 {
        self.rounds.iter().map(|r| r.red).max().unwrap() *
        self.rounds.iter().map(|r| r.green).max().unwrap() *
        self.rounds.iter().map(|r| r.blue).max().unwrap()
    }
}


fn parse_rounds(rounds_str: &str) -> Vec<Round> {
    rounds_str
        .split(";")
        .map(|round| {
            round.split(", ")
             .map(|colour| colour.split_whitespace().collect::<Vec<&str>>())
             .fold(Round { red: 0, green: 0, blue: 0 }, |acc, chunk| {
                 match chunk[..] {
                     [num, "red"] => Round { red: num.parse().unwrap_or(acc.red), ..acc },
                     [num, "green"] => Round { green: num.parse().unwrap_or(acc.green), ..acc },
                     [num, "blue"] => Round { blue: num.parse().unwrap_or(acc.blue), ..acc },
                     _ => acc
                 }
             })
        })
        .collect()
}


fn parse_game(line: &str) -> Option<Game> {
    if let [ game_id, rounds_str ] = line.split(":").collect::<Vec<&str>>()[..] {
        Some(
            Game {
                id: game_id
                    .split(" ")
                    .collect::<Vec<&str>>()[1]
                    .parse::<i32>()
                    .unwrap(),
                rounds: parse_rounds(rounds_str)
            }
        )
    } else {
        None
    }
}


fn main() {
    let input: String = read_to_string(INPUT_FILE).expect("File not found");

    let games: Vec<Game> = input
        .split("\n")
        .filter_map(|line| parse_game(line))
        .collect();

    let part_1: i32 = games
        .iter()
        .filter_map(|g| if g.is_possible() { Some(g.id) } else { None })
        .sum();

    let part_2: i32 = games
        .iter()
        .map(|g| g.min_cubes_required())
        .sum();
    
    println!("Part 1: {}", part_1);
    println!("Part 2: {}", part_2);
}
