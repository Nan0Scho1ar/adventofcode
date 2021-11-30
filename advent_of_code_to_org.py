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
    lines = re.sub("<pre>", "\n#+begin_src text\n", lines)
    lines = re.sub("</pre>", "\n#+end_src\n", lines)
    lines = re.sub("</h2>", "\n", lines)
    return lines

def src_blocks(lang, file_suffix, year, day, part, code):
    sampledata = f":var sample_data=sample-{year}-{day}"
    inputdata = f":var input_data=input-{year}-{day}"
    tangle = f":tangle /tmp/advent_of_code/aoc{year}-{day}-{part}.{file_suffix}"
    heading = "***** TODO " + lang.capitalize()
    return f"{heading}\n#+begin_src {lang} {sampledata} {inputdata} {tangle} :results output \n{code}#+end_src"

def input_src_blocks(year, day):
    sample = f"**** Sample\n#+NAME: sample-{year}-{day}\n#+begin_src bash :results output :cache yes\necho \"TODO\"\n#+end_src\n"
    input = f"**** Input\n#+NAME: input-{year}-{day}\n#+begin_src bash :results output :cache yes\necho \"TODO\"\n#+end_src\n"
    return sample + input

def new_day(year, daynum, name, desc):
    day = str(daynum).rjust(2, "0")
    out = [f"*** Day {day}:{name}"]
    for i in range(1,3):
        out.append(f"**** Part {i}")
        out.append("***** Description")
        if i == 1:
            out.append("\n".join(desc.split("\n")[1:]))
        else:
            out.append("Complete part 1 before continuing")
        out.append(src_blocks("racket", "rkt", year, day, i, '(displayln "TODO")'))
        out.append(src_blocks("python", "py",  year, day, i, 'print("TODO")'))
        out.append(src_blocks("rust",   "rs",  year, day, i, 'fn main() {println!("TODO");}'))
        out.append(src_blocks("bash",   "sh",  year, day, i, 'echo "TODO"'))
        out.append(src_blocks("awk",    "awk", year, day, i, 'BEGIN {print "TODO"}'))
        out.append(src_blocks("perl",   "pl",  year, day, i, 'print("TODO\n")'))
    return "\n".join(out)

def new_input(year, daynum, name):
    day = str(daynum).rjust(2, "0")
    return f"*** Day {day}:{name}" + "\n" + input_src_blocks(year, day)


def generate_org_file(year_start, year_stop, day_start, day_stop):
    solutions = ["* Solutions"]
    inputs = ["* Inputs"]
    for year in range(year_start, year_stop):
        solutions.append(f"** {year}")
        inputs.append(f"** {year}")
        for day in range(day_start, day_stop):
            sys.stderr.write(f"Fetching {year}-{day}...\n")
            sys.stderr.flush()
            page_text = get_description(year, day)
            name = re.sub("--- Day [0-9]+:| ---", "", page_text.split("\n")[0])
            desc = "\n".join(page_text.split("\n")[1:])
            solutions.append(new_day(year, day, name, desc))
            inputs.append(new_input(year, day, name))
    print("\n".join(solutions) + "\n" + "\n".join(inputs))


generate_org_file(2020,2021,1,26)