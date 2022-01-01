defmodule Day1 do

  def part1(fname) do
    case File.read(fname) do
      {:ok, body} -> String.trim(body)
      |> String.split("\n")
      |> Enum.map(fn x -> String.to_integer(x) end)
      |> count_larger

      {:error, reason} -> IO.puts "Error reading file: #{reason}"
    end
  end

  def count_larger(lst, accumulator \\ 0)
  def count_larger([], accumulator), do: accumulator
  def count_larger([head | tail], accumulator) do
    if (tail != []) and (head < List.first(tail)) do
      count_larger(tail, accumulator + 1)
    else
      count_larger(tail, accumulator)
    end
  end

  def main do
    IO.puts part1("sample-2021-01.txt")
    IO.puts part1("input-2021-01.txt")
  end

end
