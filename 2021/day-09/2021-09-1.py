import sys
import math
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

def find_basins(board, height, width, basins=[]):
    for i, row in enumerate(board):
        for j, num in enumerate(row):
            if i > 0 and num >= board[i-1][j]:
                continue
            elif i < height-1 and num >= board[i+1][j]:
                continue
            elif j > 0 and num >= board[i][j-1]:
                continue
            elif j < width-1 and num >= board[i][j+1]:
                continue
            basins.append([i, j, num])
    return basins

def measure_basin(board, height, width, unexplored_tiles, explored_tiles=None):
    if explored_tiles is None:
        explored_tiles = []

    if len(unexplored_tiles) == 0:
        return explored_tiles
    current_tile = unexplored_tiles.pop()
    i, j, num = current_tile
    explored_tiles.append(current_tile)
    if i > 0:
        new_tile = [i-1, j, board[i-1][j]]
        if (num < new_tile[2]) and (new_tile not in unexplored_tiles) and (new_tile not in explored_tiles) and new_tile[2] < 9:
            unexplored_tiles.append(new_tile)
    if i < height-1:
        new_tile = [i+1, j, board[i+1][j]]
        if (num < new_tile[2]) and (new_tile not in unexplored_tiles) and (new_tile not in explored_tiles) and new_tile[2] < 9:
            unexplored_tiles.append(new_tile)
    if j > 0:
        new_tile = [i, j-1, board[i][j-1]]
        if (num < new_tile[2]) and (new_tile not in unexplored_tiles) and (new_tile not in explored_tiles) and new_tile[2] < 9:
            unexplored_tiles.append(new_tile)
    if j < width-1:
        new_tile = [i, j+1, board[i][j+1]]
        if (num < new_tile[2]) and (new_tile not in unexplored_tiles) and (new_tile not in explored_tiles) and new_tile[2] < 9:
            unexplored_tiles.append(new_tile)
    return measure_basin(board, height, width, unexplored_tiles, explored_tiles)

def find_lowest(lines):
    board = [[int(char) for char in line] for line in lines.split("\n")[:-1]]
    height = len(board)
    width = len(board[0])
    basins = find_basins(board, height, width)
    sizes = [len(measure_basin(board, height, width, [basin])) for basin in basins]
    return math.prod(sorted(sizes)[-3:])

print(find_lowest(n0s1.file_to_string("sample-2021-09.txt")))
print(find_lowest(n0s1.file_to_string("input-2021-09.txt")))
