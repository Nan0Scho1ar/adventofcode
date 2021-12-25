#!/usr/bin/env python3
import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

def count_deeper(data):
    l = [int(i) for i in data[:-1].split("\n")]
    num = 0
    for i in range(3,len(l)):
        sum1 = l[i-3] + l[i-2] + l[i-1]
        sum2 = l[i-2] + l[i-1] + l[i]
        if sum2 - sum1 > 0:
            num += 1
    return num

print(count_deeper(n0s1.file_to_string("sample-2021-01.txt")))
print(count_deeper(n0s1.file_to_string("input-2021-01.txt")))
