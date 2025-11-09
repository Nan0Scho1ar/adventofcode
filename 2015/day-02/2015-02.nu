let presents = open inputs/input-2015-02.txt | lines | each { split row x | each { into int } | sort }

let areas = $presents | each {|p| [($p.0 * $p.1), ($p.1 * $p.2), ($p.0 * $p.2)] | sort}

print $"Part 1: ($areas | each {|p| ($p.0 * 3) + ($p.1 * 2) + ($p.2 * 2) } | math sum)"
print $"Part 2: ($presents | each {|p| (($p.0 + $p.1) * 2) + ($p.0 * $p.1 * $p.2)} | math sum)"