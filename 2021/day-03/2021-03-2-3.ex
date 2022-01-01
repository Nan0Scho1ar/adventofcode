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

    indicies = Enum.to_list(0..length(input))
    o2 = filtr(input, indicies, 1, 0)
    co2 = filtr(input, indicies, 0, 1)
    o2 * co2
  end

  def filtr([h | t], _, _, _) when length(t) == 0, do: bitlist_to_int(h)
  def filtr(list, [idx_h | idx_t], a, b) when length(list) > 1 do
    bits = Enum.map(list, fn x -> Enum.at(x, idx_h) end)
    most_common = (if Enum.sum(bits) >= length(list) / 2 do a else b end)
    Enum.filter(list, fn x -> Enum.at(x, idx_h) == most_common end)
    |> filtr(idx_t, a, b)
  end

  def main do
    IO.puts get_life_support("sample-2021-03.txt")
    IO.puts get_life_support("input-2021-03.txt")
  end

end
