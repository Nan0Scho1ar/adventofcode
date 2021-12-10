#!/usr/bin/env python3
# advent_of_code_to_org: Generate an org file for the advent of code challenges.
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: Tue 30 Nov 2021 23:40:45 AEST
# License: GPL v3
# Copyright (C) 2021 Christopher Mackinga <chris@n0s1.net>
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.
#
import regex as re
import requests
from bs4 import BeautifulSoup
import sys
import subprocess

def match_class(target):
    def do_match(tag):
        classes = tag.get('class', [])
        return all(c in classes for c in target)
    return do_match

def get_description(year, day):
    url = f"https://adventofcode.com/{year}/day/{day}"
    res = requests.get(url)
    html_page = res.content
    soup = BeautifulSoup(html_page, "html.parser")
    text = soup.find_all(match_class(["day-desc"]))
    lines = "\n".join(["{} ".format(t) for t in text])
    lines = re.sub("<p>|</p>|<ul>|</ul>|<code>|</code>|<h2>|<article class=\"day-desc\">|</article>", "", lines)
    lines = re.sub("<em>|</em>|<li>|</li>", "~", lines)
    lines = re.sub("<pre>", "\n#+begin_example\n", lines)
    lines = re.sub("</pre>", "\n#+end_example\n", lines)
    lines = re.sub("</h2>", "\n", lines)
    lines = re.sub("&lt;", "<", lines)
    lines = re.sub("&gt;", ">", lines)

    return lines

def src_blocks(lang, file_suffix, year, day, part, code):
    sampledata = f":var sample_data=sample-{year}-{day}"
    inputdata = f":var input_data=input-{year}-{day}"
    tangle = f":tangle /tmp/advent_of_code/aoc{year}-{day}-{part}.{file_suffix} :eval never-export"
    heading = "** TODO " + lang.capitalize()
    return f"{heading}\n#+begin_src {lang} {sampledata} {inputdata} {tangle} :results output \n{code}#+end_src"

def input_src_blocks(year, day):
    src_args = ":results output :cache yes :eval never-export"
    sample = f"** Sample\n#+NAME: sample-{year}-{day}\n#+begin_src bash {src_args}\necho \"TODO\"\n#+end_src\n"
    input = f"** Input\n#+NAME: input-{year}-{day}\n#+begin_src bash {src_args}\necho \"TODO\"\n#+end_src\n"
    return sample + input

def new_day(year, daynum, name, desc):
    day = str(daynum).rjust(2, "0")
    out = []
    for i in range(1,3):
        out.append(f"* Part {i}")
        out.append("** Description")
        if i == 1:
            out.append("\n".join(desc.split("\n")[1:]))
        else:
            out.append("Complete part 1 before continuing")
        out.append(src_blocks("racket", "rkt", year, day, i, '(displayln "TODO")\n'))
        out.append(src_blocks("python", "py",  year, day, i, 'print("TODO")\n'))
        out.append(src_blocks("rust",   "rs",  year, day, i, 'fn main() {println!("TODO");}\n'))
        out.append(src_blocks("bash",   "sh",  year, day, i, 'echo "TODO"\n'))
        out.append(src_blocks("awk",    "awk", year, day, i, 'BEGIN {print "TODO"}\n'))
        out.append(src_blocks("perl",   "pl",  year, day, i, 'print("TODO\\n")\n'))
    return "\n".join(out)

def new_input(year, daynum, name):
    day = str(daynum).rjust(2, "0")
    return f"* Inputs" + "\n" + input_src_blocks(year, day)


def generate_org_file(year, day):
    solutions = []
    inputs = []
    sys.stderr.write(f"Fetching {year}-{day}...\n")
    sys.stderr.flush()
    page_text = get_description(year, day)
    name = re.sub("--- Day [0-9]+:| ---", "", page_text.split("\n")[0])
    desc = "\n".join(page_text.split("\n")[1:])
    solutions.append(new_day(year, day, name, desc))
    inputs.append(new_input(year, day, name))
    cmd = ["org_header", f"Day {day}:{name}", f"day{day}.html", "https://github.com/Nan0Scho1ar/adventofcode"]
    output = subprocess.run(cmd, check=True, stdout=subprocess.PIPE, universal_newlines=True)
    return (output.stdout + "\n" + "\n".join(solutions) + "\n" + "\n".join(inputs), name)

stdin = sys.argv[1].split("-")
year = stdin[0]
day = stdin[1]
filelines, name = generate_org_file(year, day)
with open("README.org", "a") as f:
    f.write(f"- [[file:./{year}/day{day}.org][Day {day}: {name}]]\n")

with open(f"{year}/day{day}.org", "a") as f:
    f.write(filelines)
