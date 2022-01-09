defmodule Day8 do
  import N0S1_AOC

  def count_segments(fname) do
    input =
      read_lines(fname)
      |> Enum.map(fn line ->
        String.split(line, " | ")
        |> Enum.map(fn part ->
          String.split(part, " ")
        end)
      end)

    outputs =
      input
      |> Enum.flat_map(fn line ->
        line
        |> tl
        |> hd
        |> Enum.map(fn out -> String.length(out) end)
      end)
      |> Enum.filter(fn x -> x == 2 or x == 3 or x == 4 or x == 7 end)
      |> Enum.count()
  end

  def main do
    IO.puts(count_segments("sample-2021-08.txt"))
    IO.puts(count_segments("input-2021-08.txt"))
  end
end
