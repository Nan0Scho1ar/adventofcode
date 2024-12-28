#!/usr/bin/env python3

from collections import Counter


def read_and_split(filename):
    with open(filename) as f:
        lines = f.read().splitlines()
        pairs = [line.split("   ") for line in lines]
        int_pairs = [(int(p[0]), int(p[1])) for p in pairs]
        return zip(*int_pairs)


l1, l2 = read_and_split("input-2024-01.txt")

# Part 1
print(sum([abs(a - b) for a, b in zip(sorted(l1), sorted(l2))]))

# Part 2
l2_counts = Counter(l2)
print(sum(num * l2_counts[num] for num in l1 if num in l2_counts))
