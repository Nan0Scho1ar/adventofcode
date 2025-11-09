let vals = open inputs/input-2015-01.txt | split chars | each {|it| ((($it | into binary | into int) - 40) * -2) + 1 }

mut level = 0
for $val in ($vals | enumerate) {
    $level = $level + $val.item
    if ($level < 0) {
        print $"Part 1: ($vals | math sum)"
        print $"Part 2: ($val.index + 1)"
        break
    }
}