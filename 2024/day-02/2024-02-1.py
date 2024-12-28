#!/usr/bin/env python3


def read_and_split(filename):
    with open(filename) as f:
        return [[int(num) for num in line.split(" ")] for line in f.read().splitlines()]


def safe(report):
    pairs = zip(report[:-1], report[1:])
    delta = [p[1] - p[0] for p in pairs]
    return all(abs(num) < 4 for num in delta) and (
        all(num < 0 for num in delta) or all(num > 0 for num in delta)
    )


reports = read_and_split("input-2024-02.txt")

# Part 1
print(sum(1 for r in reports if safe(r)))

# Part 2
dampened = lambda r: any(safe(r[:i] + r[i + 1 :]) for i in range(len(r)))
print(sum(1 for r in reports if dampened(r)))
