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

  def count_larger(ht, a \\ 0)
  def count_larger([], a), do: a
  def count_larger([h | t], a) when h < hd(t), do: count_larger(t, a+1)
  def count_larger([_ | t ], a), do: count_larger(t, a)

  def main do
    IO.puts part1("sample-2021-01.txt")
    IO.puts part1("input-2021-01.txt")
  end

end
