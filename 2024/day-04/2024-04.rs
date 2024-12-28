use std::fs::read_to_string;

const INPUT_FILE: &str = "2024/day-04/input-2024-04.txt";

const WORD: &str = "XMAS";

const DIRECTIONS: [(isize, isize); 8] = [
    (-1, -1),
    (-1, 0),
    (-1, 1),
    (0, -1),
    (0, 1),
    (1, -1),
    (1, 0),
    (1, 1),
];
fn main() {
    let text = read_to_string(INPUT_FILE).expect("File not found");
    let chars: Vec<Vec<char>> = text.lines().map(|l| l.chars().collect()).collect();


    let board = &chars;
    let height = chars.len() as isize;
    let width = chars[0].len() as isize;
    let part1 = (0..height)
        .flat_map(|i| {
            (0..width).flat_map(move |j| {
                DIRECTIONS.iter().filter(move |&(offset1, offset2)| {
                    WORD.chars().enumerate().all(|(char_idx, char)| {
                        let char_idx = char_idx as isize;
                        let i = i + offset1 * char_idx;
                        let j = j + offset2 * char_idx;
                        (&i >= &0) && (&i < &height) &&
                        (&j >= &0) && (&j < &width) &&
                        (board[i as usize][j as usize] == char)
                    })
                })
            })
        })
        .count();
    println!("Part 1: {:#?}", part1);

    let part2 = (0..height)
        .flat_map(|i| {
            (0..width).flat_map(move |j| {
                if board[i as usize][j as usize] != 'A' {
                    return None;
                }
                if (&i <= &0) || (&i+1 >= height) ||
                (&j <= &0) || (&j+1 >= width) {
                    return None;
                }
                let diag1_valid = (
                    (board[(i as usize) -1][(j as usize) -1] == 'M') &&
                    (board[(i as usize) +1][(j as usize) +1] == 'S')
                ) || (
                    (board[(i as usize) -1][(j as usize) -1] == 'S') &&
                    (board[(i as usize) +1][(j as usize) +1] == 'M')
                );
                let diag2_valid = (
                    (board[(i as usize) -1][(j as usize) +1] == 'M') &&
                    (board[(i as usize) +1][(j as usize) -1] == 'S')
                ) || (
                    (board[(i as usize) -1][(j as usize) +1] == 'S') &&
                    (board[(i as usize) +1][(j as usize) -1] == 'M')
                );
                if diag1_valid && diag2_valid {
                    return Some(());
                } else {
                    return None;
                }
            })
        }).count();

    println!("Part 2: {:#?}", part2);

}
