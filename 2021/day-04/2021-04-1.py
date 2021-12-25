#!/usr/bin/env python3
import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1


#   0   1   2   3   4
#   5   6   7   8   9
#  10  11  12  13  14
#  15  16  17  18  19
#  20  21  22  23  24

def solved(board):
    for i in range(0,5):
        row_valid = True
        column_valid = True
        for j in range((i*5),5+(i*5)):
            if board[j] != "X":
                row_valid = False
        for j in range(0+i,21+i, 5):
            if board[j] != "X":
                column_valid = False
        if row_valid or column_valid:
            return True
    return False

def call_numbers(input, boards):
    for i in input:
        for b, board in enumerate(boards):
            for t, tile in enumerate(board):
                if tile == i:
                    boards[b][t] = "X"
            if solved(boards[b]):
                return [b, i]

def bingo_time(data):
    sdata = data.split("\n\n")
    input = sdata[0].split(",")
    boards = [board.replace("\n", " ").replace("  ", " ").split(" ") for board in sdata[1:]]
    winner = call_numbers(input, boards)
    sum = 0
    for i in boards[winner[0]]:
        if i != "X" and i != "":
            sum += int(i)

    return sum * int(winner[1])

print(bingo_time(n0s1.file_to_string("sample-2021-04.txt")))
print(bingo_time(n0s1.file_to_string("input-2021-04.txt")))
