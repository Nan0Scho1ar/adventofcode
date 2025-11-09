let input = open inputs/input-2015-04.txt | str trim

def mine [prefix] {
    for $i in 1..1000000000000 {
        if ($"($input)($i)" | hash md5 | str starts-with $prefix) {
            print ($"($input)($i)" | hash md5)
            return $i
        }
    }
}

print ($"Part 1: (mine '00000')")
print ($"Part 2: (mine '000000')")