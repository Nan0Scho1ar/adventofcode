defmodule Day3 do
  import N0S1_AOC

  def get_life_support(fname) do
    input = read_lines(fname)
    |> Enum.map(fn x ->
      String.split(x, "", trim: true)
      |> Enum.map(fn y ->
        String.to_integer(y)
      end)
    end)
    |> transpose

    threshold = length(hd(input)) / 2

    gamma = Enum.map(input, fn x ->
      if Enum.sum(x) >= threshold do 1 else 0 end
    end)

    epsilon = Enum.map(gamma, fn x -> (x - 1) * -1 end)

    bitlist_to_int(gamma) * bitlist_to_int(epsilon)
  end

  def main do
    IO.puts get_life_support("sample-2021-03.txt")
    IO.puts get_life_support("input-2021-03.txt")
  end

end
