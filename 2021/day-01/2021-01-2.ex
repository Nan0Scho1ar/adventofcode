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

  def count_larger(nums) do
    lists = [nums, tl(nums), tl(tl(nums)), tl(tl(tl(nums)))]
    Enum.zip_reduce(lists, 0, fn elem, acc ->
      [a,b,c,d] = elem
      if a+b+c < b+c+d do
         acc + 1
      else
         acc
      end
    end)
  end

  def main do
    IO.puts part1("sample-2021-01.txt")
    IO.puts part1("input-2021-01.txt")
  end

end
