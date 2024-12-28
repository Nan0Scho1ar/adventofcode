# Experimental!

# Part 0
# ⊜(⋕⊜□⊸≠@ )⊸≠@\n&fras "input-2024-01.txt"
# :/+⌵≡/-⍜⍉≡⍆.
# /+▽=,°⊟₂⍉/⊂⊞⊂°⊟₂⍉

# Part 0
&fras "input-2024-01.txt" # File Read As String
⊜(⋕⊜□⊸≠@ )⊸≠@\n           # Split on newlines then on spaces and parse as numbers

# Part 1
⍜⍉≡⍆     # Sort Under Transpose
:/+⌵≡/-. # Sum Absolute value of subtracted pairs

# Part 2
°⊟⍉  # Transpose onto stack
/⊂⊞⊂ # Build permutations
°⊟⍉  # Transpose onto stack
=,   # Build Mask
▽    # Apply Mask
/+   # Sum Equal

# ⊜(⋕⊜□⊸≠@ )⊸≠@\n&fras "input-2024-01.txt"
# :/+⌵≡°⊟⍉⊜(⋕⊜□⊸≠@ )⊸≠@\n
# ∩/+⊃(▽=,°⊟⍉/⊂⊞⊂|⌵-∩⍆)/-⍜⍉≡⍆.
# /+▽=,°⊟⍉/⊂⊞⊂°⊟⍉

# V2
# °⊟⍉⊜(⋕⊜□⊸≠@ )⊸≠@\n
# ∩/+⊃(▽=,°⊟⍉/⊂⊞⊂|⌵-∩⍆)
