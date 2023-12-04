use std::fs::read_to_string;

fn main() {
    // Read the file
    let contents = read_to_string("./day-01/input-2023-01.txt").expect("File not found");

    // Parse lines to ints
    let depths = contents
        .split("\n")
        .map(|s| s.parse::<i32>())
        .filter_map(Result::ok)
        .collect::<Vec<i32>>();

    // Window and count the number which are greater
    let num_greater = depths
        .windows(2)
        .filter(|&window| window[0] < window[1]) 
        .count(); 

    // Build sums of each 3 consecutive elements then
    // count how many of those sums are greater
    let num_greater2 = depths
        .windows(3)
        .map(|w| w.iter().sum())
        .collect::<Vec<i32>>()
        .windows(2)
        .filter(|&window| window[0] < window[1]) 
        .count(); 

    println!("Part 1: {}", num_greater);
    println!("Part 2: {}", num_greater2);
}
