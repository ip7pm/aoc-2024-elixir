Code.require_file "./matrix.ex"

defmodule Day01 do

  def part1(input) do
    [left, right] = parse input
    Enum.zip(Enum.sort(left), Enum.sort(right))
    |> Enum.reduce(0, fn {a, b}, acc -> acc + abs(a - b) end)
  end

  def part2(input) do
    [left, right] = parse input
    Enum.reduce(left, 0, fn i, acc ->
      acc + (i * Enum.count(right, &(&1 == i)))
    end)
  end

  def parse(input) do
    Matrix.parse(input, sep: " ", to: :int) |> Matrix.transpose()
  end
end

# -----

input_test = """
3   4
4   3
2   5
1   3
3   9
3   3
"""

{_, input} = File.read "./files/day01_input.txt"

IO.puts "--------------------------------------------------"

IO.puts "Part1 :: Test :: Result = #{Day01.part1(input_test)}"
IO.puts "Part1 :: Result = #{Day01.part1(input)}"

IO.puts "--------------------------------------------------"

IO.puts "Part2 :: Test :: Result = #{Day01.part2(input_test)}"
IO.puts "Part2 :: Result = #{Day01.part2(input)}"

IO.puts "--------------------------------------------------"
