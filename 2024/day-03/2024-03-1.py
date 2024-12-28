#!/usr/bin/env python3

import re


def mul(input):
    pairs = re.findall(r"mul\((\d+),(\d+)\)", input)
    return sum(int(p[0]) * int(p[1]) for p in pairs)


with open("input-2024-03.txt") as f:
    input = f.read()
    print(mul(input))  # Part 1
    print(mul(re.sub(r"(?s)don't\(\).*?do\(\)", "", input)))  # Part 2
