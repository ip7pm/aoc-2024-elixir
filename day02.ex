Code.require_file "./matrix.ex"

defmodule Day02 do

  def part1(input) do
    parse(input)
    |> Enum.filter(&safe?(&1))
    |> Enum.count()
  end

  def part2(input) do
    parse(input)
    |> Enum.filter(fn row ->
      if safe? row do
        true
      else
        0..length(row)-1
        |> Enum.map(&(safe? List.delete_at(row, &1)))
        |> Enum.any?
      end
    end)
    |> Enum.count()
  end

  defp parse(input) do
    Matrix.parse(input, sep: " ", to: :int)
  end

  defp safe?(row) do
    diff =
      row
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [a, b] -> a - b end)
    increase = Enum.all? diff, &(&1 > 0 and &1 < 4)
    decrease = Enum.all? diff, &(&1 < 0 and &1 > -4)
    increase or decrease
  end
end

# -----

input_test = """
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""

{_, input} = File.read "./files/day02_input.txt"

IO.puts "--------------------------------------------------"

IO.puts "Part1 :: Test :: Result = #{Day02.part1(input_test)}"
IO.puts "Part1 :: Result = #{Day02.part1(input)}"

IO.puts "--------------------------------------------------"

IO.puts "Part2 :: Test :: Result = #{Day02.part2(input_test)}"
IO.puts "Part2 :: Result = #{Day02.part2(input)}"

IO.puts "--------------------------------------------------"
