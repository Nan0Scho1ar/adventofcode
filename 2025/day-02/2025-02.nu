open ../../inputs/input-2025-02.txt 
| split row , 
| split column - start end
| each -f {|e| ($e.start | into int)..($e.end | into int) | into string }
| tee { print $"Part 1: ($in | where $it =~ '^(.+)\1$' | into int | math sum)" }
| print $"Part 2: ($in | where $it =~ '^(.+)\1+$' | into int | math sum)"