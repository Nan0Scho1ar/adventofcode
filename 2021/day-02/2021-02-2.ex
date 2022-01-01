defmodule Day2 do

  def get_position(fname) do
    case File.read(fname) do
      {:ok, body} -> String.trim(body)
      |> String.split("\n")
      |> Enum.map(fn x -> [k | [v | _]] = String.split(x)
          [String.to_atom(k), String.to_integer(v)] end)
      |> calc_pos
    {:error, reason} -> IO.puts "Error reading file: #{reason}"
    end
  end

  def calc_pos(ht, x \\ 0, y \\ 0, aim \\ 0)
  def calc_pos([], x, y, _), do: x * y
  def calc_pos([[d | [v | _]] | t], x, y, aim) do
    case d do
      :forward -> calc_pos(t, x + v, y + (v * aim), aim)
      :down ->    calc_pos(t, x, y, aim + v)
      :up ->      calc_pos(t, x, y, aim - v)
    end
  end

  def main do
    IO.puts get_position("sample-2021-02.txt")
    IO.puts get_position("input-2021-02.txt")
  end

end
