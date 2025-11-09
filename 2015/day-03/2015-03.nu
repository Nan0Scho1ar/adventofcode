let moves = open inputs/input-2015-03.txt | split chars

def new-pos [pos, move] {
    match $move {
        '^' => [$pos.0, ($pos.1 + 1)]
        'v' => [$pos.0, ($pos.1 - 1)]
        '>' => [($pos.0 + 1), $pos.1]
        '<' => [($pos.0 - 1), $pos.1]
    }
}

mut pos = [0, 0]
mut visited = []

for move in $moves {
    $pos = new-pos $pos $move
    $visited = $visited | append [$pos]
}

print $"Part 1: ($visited | uniq | length)"

mut pos = [0, 0]
mut visited = []

mut robo = false
mut robo_pos = [0, 0]

for move in $moves {
  if $robo {
    $robo_pos = new-pos $robo_pos $move
    $visited = $visited | append [$robo_pos]
  } else {
    $pos = new-pos $pos $move
    $visited = $visited | append [$pos]
  }

  $robo = not $robo
}

print $"Part 2: ($visited | uniq | length)"