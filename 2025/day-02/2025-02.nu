open ../../inputs/input-2025-02.txt 
| split row , 
| each -f { split row - | into int | seq ...$in | into string }
| tee { print $"Part 1: ($in | find -nr '^(.+)\1$' | into int | math sum)" }
| print $"Part 2: ($in | find -nr '^(.+)\1+$' | into int | math sum)"