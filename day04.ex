defmodule Day04 do

  def part1(input) do
    mat = parse input
    steps = [ {0, 1}, {0, -1}, {1, 0}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]
    all_char_positions(mat, "X")
    |> Enum.map(fn {row, col} ->
      steps
      |> Enum.map(fn step -> "XMAS" == word(mat, row, col, step) |> Enum.join("") end)
      |> Enum.count(&(&1))
    end)
    |> Enum.sum()
  end

  def part2(input) do
    mat = parse input
    deltas = [{-1, -1}, {-1, 1}, {1, -1}, {1, 1}]
    all_char_positions(mat, "A")
    |> Enum.map(fn {row, col} ->
      pattern =
        deltas
        |> Enum.map(fn {dr, dc} -> mat_at(mat, row + dr, col + dc) end)
        |> Enum.join("")
      Enum.any? ["MSMS", "SMSM", "MMSS", "SSMM"], fn s -> pattern == s end
    end)
    |> Enum.count(&(&1))
  end

  defp all_char_positions(mat, char) do
    mat
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, i} ->
      row
      |> Enum.with_index()
      |> Enum.filter(fn {c, _} -> c == char end)
        |> Enum.map(fn {_, j} -> {i, j} end)
    end)
  end

  defp word(mat, row, col, {dr, dc}) do
    0..3
    |> Enum.map(fn i -> mat_at(mat, row + i * dr, col + i * dc) end)
    |> Enum.filter(&(&1 != nil))
  end

  defp mat_at(mat, row, col) do
    rows = length mat
    cols = List.first(mat) |> length()
    if row >= 0 and row < rows and col >= 0 and col < cols do
      Enum.at(mat, row) |> Enum.at(col)
    else
      nil
    end
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
  end
end

# -----

input_test_1 = """
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"""

input_test_2 = """
.M.S......
..A..MSMS.
.M.S.MAA..
..A.ASMSM.
.M.S.M....
..........
S.S.S.S.S.
.A.A.A.A..
M.M.M.M.M.
..........
"""

{_, input} = File.read "./files/day04_input.txt"

IO.puts "--------------------------------------------------"

IO.puts "Part1 :: Test :: Result = #{Day04.part1(input_test_1)}"
IO.puts "Part1 :: Result = #{Day04.part1(input)}"

IO.puts "--------------------------------------------------"

IO.puts "Part2 :: Test :: Result = #{Day04.part2(input_test_2)}"
IO.puts "Part2 :: Result = #{Day04.part2(input)}"

IO.puts "--------------------------------------------------"
