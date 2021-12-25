#!/usr/bin/env python3
import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

def get_pos(data):
    depth = 0
    horizontal = 0
    aim = 0
    for line in data[:-1].split("\n"):
        d = line.split(" ")
        if d[0] == "forward":
            horizontal += int(d[1])
            depth += (int(d[1]) * aim)
        elif d[0] == "down":
            aim += int(d[1])
        elif d[0] == "up":
            aim -= int(d[1])
    return depth * horizontal

print(get_pos(n0s1.file_to_string("sample-2021-02.txt")))
print(get_pos(n0s1.file_to_string("input-2021-02.txt")))
