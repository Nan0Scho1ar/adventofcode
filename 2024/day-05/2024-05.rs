use std::fs::read_to_string;

const INPUT_FILE: &str = "2024/day-05/input-2024-05.txt";

fn main() {
    let text = read_to_string(INPUT_FILE).expect("File not found");
    let sections: Vec<&str> = text.split("\n\n").collect();
    let orderings: Vec<(usize, usize)> = sections[0]
        .lines()
        .map(|line| {
            let nums: Vec<usize> = line.split("|").filter_map(|s| s.parse().ok()).collect();
            (nums[0], nums[1])
        })
        .collect();

    let updates: Vec<Vec<usize>> = sections[1]
        .lines()
        .map(|line| line.split(",").filter_map(|s| s.parse().ok()).collect())
        .collect();


    let (clean, dirty): (Vec<_>, Vec<_>) = updates.into_iter()
        .partition(|update| {
            orderings.iter().all(|(a, b)| {
                let pos_a = update.iter().position(|p| p == a);
                let pos_b = update.iter().position(|p| p == b);
                pos_a.zip(pos_b).map_or(true, |(pos_a, pos_b)| pos_b >= pos_a)
            })
        });

    let dirty = dirty.into_iter().map(|mut update| {
        let mut swapped = true;
        while swapped {
            swapped = false;
            for (a, b) in &orderings {
                let pos_a = update.iter().position(|p| p == a);
                let pos_b = update.iter().position(|p| p == b);
                if let (Some(pos_a), Some(pos_b)) = (pos_a, pos_b) {
                    if pos_b < pos_a {
                        update.swap(pos_a, pos_b);
                        swapped = true;
                    }
                }
            }
        }
        update
    }).collect::<Vec<_>>();

    let part1: usize = clean.iter().map(|update| update[update.len() / 2]).sum();
    let part2: usize = dirty.iter().map(|update| update[update.len() / 2]).sum();


    println!("Part 1: {:#?}", part1);
    println!("Part 2: {:#?}", part2);
}
