module aoc {
  def pandoc-filter [] {
    """
    function Header(elem)
      elem.identifier = ""
      return elem
    end
    """ | save -f /tmp/remove-header.lua

    "/tmp/remove-header.lua"
  }

  def req-headers [] {
    let session_token = open ./session.token | str trim
    {Cookie: $"session=(session_token)"}
  }

  export def get-input [year: int, day: int] {
    let padded_day = $day | fill -a r -w 2 -c 0
    let outfile = $"inputs/($year)-($padded_day).txt"
    http get --headers (req-headers) https://adventofcode.com/($year)/day/($day)/input | save -f $outfile
  }

  export def get-question [year: int, day: int] {
    let padded_day = $day | fill -a r -w 2 -c 0
    let outfile = $"($year)/day-($padded_day)/($year)-($padded_day).md"

    http get --headers (req-headers) https://adventofcode.com/($year)/day/($day) | query web -m -q 'article' | save -rf /tmp/aoc.html
    pandoc -f html -t markdown -i /tmp/aoc.html -o $outfile --lua-filter=(pandoc-filter)
  }
}

use aoc