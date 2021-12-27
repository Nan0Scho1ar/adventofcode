import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

def best_neighbor(data):
    data = [int(d) for d in data.split(",")]
    costs = [sum( [abs(d - i) for d in data] ) for i in range(min(data), max(data)+1)]
    return min(costs)

print(best_neighbor(n0s1.file_to_string("sample-2021-07.txt")))
print(best_neighbor(n0s1.file_to_string("input-2021-07.txt")))
