Code.require_file "./matrix.ex"

defmodule Day04 do

  def part1(input) do
    mat = Matrix.parse input
    steps = [ {0, 1}, {0, -1}, {1, 0}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]
    Matrix.positions(mat, "X")
    |> Enum.map(fn {row, col} ->
      steps
      |> Enum.map(fn step -> "XMAS" == Matrix.vect_by_step(mat, row, col, step, 0..3) |> Enum.join("") end)
      |> Enum.count(&(&1))
    end)
    |> Enum.sum()
  end

  def part2(input) do
    mat = Matrix.parse input
    deltas = [{-1, -1}, {-1, 1}, {1, -1}, {1, 1}]
    Matrix.positions(mat, "A")
    |> Enum.map(fn {row, col} ->
      pattern =
        deltas
        |> Enum.map(fn {dr, dc} -> Matrix.at(mat, row + dr, col + dc) end)
        |> Enum.join("")
      Enum.any? ["MSMS", "SMSM", "MMSS", "SSMM"], fn s -> pattern == s end
    end)
    |> Enum.count(&(&1))
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
