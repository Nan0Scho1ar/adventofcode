open ../../inputs/input-2025-02.txt 
| split row , 
| each -f { split row - | into int | seq ...$in | into string }
| tee { print $"Part 1: ($in | where $it =~ '^(.+)\1$' | into int | math sum)" }
| print $"Part 2: ($in | where $it =~ '^(.+)\1+$' | into int | math sum)"