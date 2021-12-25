import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

from collections import deque

def str_to_deque(data):
    groups = deque([0,0,0,0,0,0,0,0,0])
    for i in data.split(","):
        groups[int(i)] += 1
    return groups

def simulate(data, time):
    fishes = data.popleft()
    data.append(fishes) # Babies
    data[6] += fishes   # Reset parents
    return sum(data) if time == 1 else simulate(data, time - 1)

print(simulate(str_to_deque(sample_data), 80))
print(simulate(str_to_deque(input_data), 80))

print(simulate(str_to_deque(n0s1.file_to_string("sample-2021-01.txt"))), 80)
print(simulate(str_to_deque(n0s1.file_to_string("input-2021-01.txt"))), 80)
