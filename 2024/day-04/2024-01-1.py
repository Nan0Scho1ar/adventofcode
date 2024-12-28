#!/usr/bin/env python3

with open("sample-2024-04.txt") as f:
    board = [[c for c in l] for l in f.read().splitlines()]
    print(board)

# forward
for row in board:
