defmodule Day2 do

  def get_position(fname) do
    case File.read(fname) do
      {:ok, body} -> String.trim(body)
      |> String.split("\n")
      |> Enum.map(fn x ->
          [h|t] = String.split(x)
          [String.to_atom(h), String.to_integer(hd(t))]
        end)
        |> calc_pos

    {:error, reason} -> IO.puts "Error reading file: #{reason}"
    end
  end

  def calc_pos(ht, x \\ 0, y \\ 0)
  def calc_pos([], x, y), do: x * y
  def calc_pos([[d | [v | _]] | t], x, y) when d == :forward do
    calc_pos(t, x + v, y)
  end
  def calc_pos([[d | [v | _]] | t], x, y) when d == :up do
    calc_pos(t, x, y - v)
  end
  def calc_pos([[d | [v | _]] | t], x, y) when d == :down do
    calc_pos(t, x, y + v)
  end

  def main do
    IO.puts get_position("sample-2021-02.txt")
    #IO.puts part1("input-2021-02.txt")
  end

end
