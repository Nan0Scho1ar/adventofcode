import sys
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

opening = ['(','[', '{', '<']
closing = [')', ']', '}', '>']
points = [3, 57, 1197, 25137]

def parse(to_parse, expects=None):
    chars, error = to_parse
    if len(chars) == 0:
        return [chars, error]
    char = chars.pop(0)
    if char == expects:        # Successful match
        return [chars, None]
    elif char in closing:      # Error
        return [[], [expects, char]]
    if char in opening:
        chars, error = parse([chars, None], closing[opening.index(char)])
        if len(chars) == 0:
            return [chars, error]
    return parse([chars, None], expects)

def find_errors(string):
    lines = [[c for c in line] for line in string.split("\n")[:-1]]
    score = 0
    for line in lines:
        result, error = parse([line, []])
        if error is not None:
            expected, found = error
            score += points[closing.index(found)]
    return score

print(find_errors(n0s1.file_to_string("sample-2021-10.txt")))
print(find_errors(n0s1.file_to_string("input-2021-10.txt")))
