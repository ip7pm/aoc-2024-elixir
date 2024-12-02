defmodule Day01 do

  def part1(input) do
    {left, right} = parse input
    Enum.zip(Enum.sort(left), Enum.sort(right))
    |> Enum.reduce(0, fn {a, b}, acc -> acc + abs(a - b) end)
  end

  def part2(input) do
    {left, right} = parse input
    Enum.reduce(left, 0, fn i, acc ->
      acc + (i * Enum.count(right, &(&1 == i)))
    end)
  end

  defp parse(input) do
    {left, right} =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> Enum.map(fn [a, b] -> {a, b} end)
      |> Enum.unzip()
    {Enum.map(left, &String.to_integer(&1)), Enum.map(right, &String.to_integer(&1))}
  end
end


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
