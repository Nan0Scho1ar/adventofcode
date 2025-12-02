open ../../inputs/input-2025-02.txt 
| split row , 
| each -f { seq ...($in | split row - | into int) | into string }
| tee { print $"Part 1: ($in | where $it =~ '^(.+)\1$' | into int | math sum)" }
| print $"Part 2: ($in | where $it =~ '^(.+)\1+$' | into int | math sum)"