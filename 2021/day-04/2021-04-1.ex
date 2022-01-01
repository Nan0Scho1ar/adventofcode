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
    states = List.duplicate(0, length(boards))
    |> Enum.with_index
    |> Enum.zip(boards)
    call_numbers(calls, states, nil)
  end

  def call_numbers([num | t], boards, winner) do
    try do
      new_boards = Enum.map(boards, fn {{state, idx}, board} ->
        match = Enum.find_index(board, fn cell -> cell == num end)
        if match == nil do
          {{state, idx}, board}
        else
          new_state = state + 2 ** match
          if Enum.any?(@win_conds, fn wc -> band(new_state, wc) == wc end) do
            throw({:winner, {num, new_state, board}})
          else
            {{new_state, idx}, board}
          end
        end
      end)
      call_numbers(t, new_boards, winner)
    catch
      {:winner, w} -> w
    end
  end

  def main do
    IO.puts bingo_time("sample-2021-04.txt")
    IO.puts bingo_time("input-2021-04.txt")
  end

end
