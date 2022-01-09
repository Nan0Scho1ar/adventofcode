defmodule Day8 do
  import N0S1_AOC

  def count_segments(fname) do
    read_lines(fname)
    |> Enum.flat_map(fn line ->
      String.split(line, " | ")
      |> List.last()
      |> String.split(" ")
      |> Enum.filter(fn out ->
        Enum.member?([2, 3, 4, 7], String.length(out))
      end)
    end)
    |> Enum.count()
  end

  def main do
    IO.puts(count_segments("sample-2021-08.txt"))
    IO.puts(count_segments("input-2021-08.txt"))
  end
end
