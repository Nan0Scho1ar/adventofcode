#!/usr/bin/env python3
import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

def bit_count(lines, i):
    return sum([((num >> i) & 1) for num in [int(i, 2) for i in lines]])

def get_power(lines):
    gamma = sum([(1 << i) if bit_count(lines, i) > len(lines)/2 else 0 for i in range(len(lines[0])-1,-1,-1)])
    return gamma * ((~gamma) & int("1" * len(lines[0]),2))

print(get_power(n0s1.file_to_strings("sample-2021-03.txt")))
print(get_power(n0s1.file_to_strings("input-2021-03.txt")))
