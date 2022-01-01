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

    gamma = fn data, threshold ->
      Enum.map(transpose(data), fn x ->
        if Enum.sum(x) >= threshold do 1 else 0 end
      end)
    end

    epsilon = fn data, threshold ->
      Enum.map(transpose(data), fn x ->
        if Enum.sum(x) >= threshold do 0 else 1 end
      end)
    end

    indicies = Enum.to_list(0..length(input))
    o2 = filtr(input, indicies, gamma) |> bitlist_to_int
    co2 = filtr(input, indicies, epsilon) |> bitlist_to_int
    o2 * co2
  end

  def filtr([h | t], _, _) when length(t) == 0, do: h
  def filtr(list, [idx_h | idx_t], func) when length(list) > 1 do
    Enum.filter(list, fn x ->
      Enum.at(x, idx_h) == Enum.at(func.(list, length(list) / 2), idx_h)
    end)
    |> filtr(idx_t, func)
  end

  def main do
    IO.puts get_life_support("sample-2021-03.txt")
    IO.puts get_life_support("input-2021-03.txt")
  end

end
