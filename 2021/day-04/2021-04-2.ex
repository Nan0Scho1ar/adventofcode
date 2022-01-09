defmodule Day4 do
  import N0S1_AOC
  use Bitwise
  @win_conds [31, 992, 31744, 1015808, 32505856, 1082401,
              2164802, 4329604, 8659208, 17318416]

  def bingo_time(fname) do
    input = read_file(fname) |> String.split("\n\n")
    calls = hd(input) |> String.split(",")
    boards = tl(input) |> Enum.map(fn board ->
      String.replace(board, "  ", " ") |> String.split()
    end)

    {last_call, winning_state, winning_board} = call_numbers(calls, boards)

    # Apply bitmask to remove called numbers
    not_called = Enum.reverse(int_to_bitlist(winning_state, 25))
    |> Enum.zip(winning_board)
    |> Enum.flat_map(fn {bit, board_cell} ->
      if bit == 0 do [String.to_integer(board_cell)] else [] end
    end)

    Enum.sum(not_called) * String.to_integer(last_call)
  end

  def call_numbers(calls, boards) do
    call_numbers(calls, Enum.map(boards, fn b -> {0, b} end), [])
  end
  def call_numbers([], _, winners), do: hd(winners)
  def call_numbers(_, [], winners), do: hd(winners)
  def call_numbers([num | t], boards, winners) do
    {new_boards, new_winners} = process_boards(num, boards, [], winners)
    call_numbers(t, new_boards, new_winners)
  end

  def process_boards(_, [], processed, winners), do: {processed, winners}
  def process_boards(num, [{state, board} | t], processed, winners) do
    new_state = state + bsl(1, index_of(board, num))
    if Enum.any?(@win_conds, fn wc -> band(new_state, wc) == wc end) do
      process_boards(num, t, processed, [{num, new_state, board} | winners])
    else
      process_boards(num, t, [{new_state, board} | processed], winners)
    end
  end

  def main do
    IO.puts bingo_time("sample-2021-04.txt")
    IO.puts bingo_time("input-2021-04.txt")
  end

end
