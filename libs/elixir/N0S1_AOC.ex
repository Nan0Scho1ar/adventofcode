defmodule N0S1_AOC do

  #BEGIN Transpose
  def transpose(m), do: attach_row(m, [])

  def attach_row([], result), do: reverse_rows(result, [])
  def attach_row(row_list, result) do
    [first_row | other_rows] = row_list
    new_result = make_column(first_row, result)
    attach_row(other_rows, new_result)
  end

  def make_column([], result), do: result
  def make_column(row, []) do
    [first_item | other_items] = row
    [[first_item] | make_column(other_items, [])]
  end
  def make_column(row, result) do
    [first_item | other_items] = row
    [first_row | other_rows] = result
    [[first_item | first_row] | make_column(other_items, other_rows)]
  end

  def reverse_rows([], result), do: Enum.reverse(result)
  def reverse_rows(rows, result) do
    [first | others] = rows
    reverse_rows(others, [Enum.reverse(first) | result])
  end
  #END Transpose

  #Read lines of file to a list of strings
  def read_file(fname) do
    case File.read(fname) do
      {:ok, body} -> String.trim(body)
      {:error, reason} -> IO.puts "Error reading file: #{reason}"
    end
  end

  #Read lines of file to a list of strings
  def read_lines(fname) do
    case File.read(fname) do
      {:ok, body} -> String.trim(body) |> String.split("\n")
      {:error, reason} -> IO.puts "Error reading file: #{reason}"
    end
  end

  # convert list of bits to an integer (big endian)
  # Should probably just use Integer.undigits
  def bitlist_to_int(bits) do
    [(length(bits) - 1)..0, bits]
    |> Enum.zip_reduce(0, fn [idx, bit], acc ->
      acc + (bit * (2 ** idx))
    end)
  end

  # Convert an int to a list of bits with length `len`
  def int_to_bitlist(int, len) do
    bits = Integer.digits(int, 2)
    if length(bits) < len do
      List.duplicate(0, len - length(bits)) ++ bits
    else
      bits
    end
  end

  def index_of(list, elem) do
    idx = Enum.find_index(list, fn x -> x == elem end)
    if idx == nil do -1 else idx end
  end

end
