import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

def print_board(board):
   for line in board:
       print("".join(["." if char == 0 else str(char) for char in line]))

def count_intersections(data, boardsize):
    positions = [[[int(i.strip()) for i in pos.split(",")] for pos in line.split("->")] for line in data.split("\n")]
    board = [[0 for i in range(boardsize)] for i in range(boardsize)]
    for pair in positions:
        x1 = pair[1][1]
        x2 = pair[0][1]
        y1 = pair[1][0]
        y2 = pair[0][0]
        if x1 == x2:
            y_start = y1 if y1 < y2 else y2
            y_stop = y2 if y1 < y2 else y1
            for y in range(y_start, y_stop+1):
                board[x1][y] += 1
        elif y1 == y2:
            x_start = x1 if x1 < x2 else x2
            x_stop = x2 if x1 < x2 else x1
            for x in range(x_start, x_stop+1):
                board[x][y1] += 1
        else:
            y_dir = 1 if y1 < y2 else -1
            x_dir = 1 if x1 < x2 else -1
            for x, y in zip(range(x1, x2+x_dir, x_dir), range(y1, y2+y_dir, y_dir)):
                board[x][y] += 1
    return sum([len([i for i in row if i > 1]) for row in board])

print(count_intersections(n0s1.file_to_string("sample-2021-05.txt"), 10))
print(count_intersections(n0s1.file_to_string("input-2021-05.txt"), 1000))
