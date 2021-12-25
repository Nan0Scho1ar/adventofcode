import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

# 1  2  3  4  5  6
#    3  6 10 15 21

def best_neighbor(data):
    data = [int(d) for d in data.split(",")]
    costs = []
    base_cost = [0]
    for i in range(1, max(data)+1):
        base_cost.append(i + base_cost[i-1])
    for i in range(min(data),max(data)+1):
        cost = []
        for d in data:
            delta = abs(d - i)
            c = base_cost[delta]
            cost.append(c)
        costs.append(sum(cost))
    #val, idx = min((val, idx) for (idx, val) in enumerate(costs))
    return min(costs)

print(best_neighbor(n0s1.file_to_string("sample-2021-01.txt")))
print(best_neighbor(n0s1.file_to_string("input-2021-01.txt")))
