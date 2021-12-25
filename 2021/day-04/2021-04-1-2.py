#!/usr/bin/env python3
import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

#   0   1   2   3   4
#   5   6   7   8   9
#  10  11  12  13  14
#  15  16  17  18  19
#  20  21  22  23  24

def bingo_time(data):
    win_conds = [31, 992, 31744, 1015808, 32505856, 1082401, 2164802, 4329604, 8659208, 17318416]
    boards = [[b for b in board.replace("\n", " ").replace("  ", " ").split(" ") if b != ""] for board in data[1:]]
    states = [0 for board in boards]
    for i in data[0].split(","):
        for b, board in enumerate([b for b in boards if i in b]):
            states[b] += (1 << board.index(i))
            if any([True for cond in win_conds if states[b] & cond == cond]):
                return int(i) * sum([int(num) for j, num in enumerate(board) if states[b] & (1 << j) == 0])

print(bingo_time(n0s1.file_to_string("sample-2021-04.txt")))
print(bingo_time(n0s1.file_to_string("input-2021-04.txt")))
