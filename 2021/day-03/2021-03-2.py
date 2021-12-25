#!/usr/bin/env python3
import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

def most_common(lines, depth):
    return int(sum([int(char[depth]) for char in lines]) / len(lines) >= 0.5)

def get_val(lines, isCo2, depth=0):
    lines = [l for l in lines if (int(l[depth]) == most_common(lines, depth) ^ isCo2)]
    return lines if len(lines) < 2 else get_val(lines, isCo2, depth + 1)

def get_life_support(lines):
    return int(get_val(lines, False)[0], 2) * int(get_val(lines, True)[0], 2)

print(get_life_support(n0s1.file_to_strings("sample-2021-03.txt")))
print(get_life_support(n0s1.file_to_strings("input-2021-03.txt")))
