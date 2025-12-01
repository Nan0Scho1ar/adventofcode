open ../../inputs/input-2025-01.txt  
| str replace -a 'L' '-' 
| str replace -a 'R' '' 
| lines 
| each {|| into int }
| reduce --fold {dial: 50, part1: 0, part2: 0} {|move, acc|
    let new_dial = ($acc.dial + $move) mod 100
    let landed = $new_dial == 0 | into int
    let overspins = $move // (((($move < 0 | into int) * 2) - 1) * -100)
    let passed_left = $new_dial > $acc.dial and $acc.dial != 0 and $move < 0
    let passed_right = $new_dial < $acc.dial and $move > 0
    let passed = $new_dial == 0 or $passed_left or $passed_right | into int
    { dial: $new_dial, part1: ($acc.part1 + $landed), part2: ($acc.part2 + $passed + $overspins) }
} 
| select part1 part2
