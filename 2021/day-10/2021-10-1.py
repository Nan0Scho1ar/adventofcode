import sys
import math
sys.path.append("../../libs/python")
import n0s1_aoc as n0s1

def valid(to_parse, expects=None):
    chars, error = to_parse
    #print(expects, ":", chars)
    if len(chars) == 0:
        print(expects)
        return [chars, error]
    char = chars.pop(0)
    opening = ['(','{', '[', '<']
    closing = [')', '}', ']', '>']

    # If we found the matching close, return all remaing chars
    # to the parent
    if char == expects:
        return [chars, None]
    # If we found the wrong closing tag, report the syntax error.
    elif char in closing:
        return [[], [expects, char]]

    if char in opening:
        chars, error = valid([chars, None], closing[opening.index(char)])
        if len(chars) == 0:
            return [chars, error]

    return valid([chars, None], expects)




def find_errors(string):
    lines = [[c for c in line] for line in string.split("\n")[:-1]]
    score = 0
    for line in lines:
        #print(line)
        result, error = valid([line, []])
        if error is not None:
            expected, found = error
            if found == ")":
                score += 3
            if found == "]":
                score += 57
            if found == "}":
                score += 1197
            if found == ">":
                score += 25137
    return score



print(find_errors(n0s1.file_to_string("sample-2021-10.txt")))
print(find_errors(n0s1.file_to_string("input-2021-10.txt")))
