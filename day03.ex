defmodule Day03 do

  def part1(input) do
    Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)/, input)
    |> Enum.reduce(0, fn [_, a, b], acc ->
      acc + String.to_integer(a) * String.to_integer(b)
    end)
  end

  def part2(input) do
    Regex.replace(~r/don't\(\).+?do\(\)|don't\(\).*$/, String.replace(input, "\n", ""), "")
    |> part1
  end
end

# -----

input_test_1 = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

input_test_2 = """
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64]
(mul(11,8)undo()?mul(8,5))
"""

{_, input} = File.read "./files/day03_input.txt"

IO.puts "--------------------------------------------------"

IO.puts "Part1 :: Test :: Result = #{Day03.part1(input_test_1)}"
IO.puts "Part1 :: Result = #{Day03.part1(input)}"

IO.puts "--------------------------------------------------"

IO.puts "Part2 :: Test :: Result = #{Day03.part2(input_test_2)}"
IO.puts "Part2 :: Result = #{Day03.part2(input)}"
#
IO.puts "--------------------------------------------------"
