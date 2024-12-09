Code.require_file "./matrix.ex"

defmodule Day07 do

  def part1(input) do
    parse(input)
    |> Enum.filter(&(valid? :p1, &1))
    |> sum_of_equations()
  end

  def part2(input) do
    parse(input)
    |> Enum.filter(&(valid? :p2, &1))
    |> sum_of_equations()
  end

  defp parse(input) do
    Matrix.parse(input, sep: ":")
    |> Enum.map(fn [test, numbers] ->
      [String.to_integer(test), List.first Matrix.parse(numbers, sep: " ", to: :int)]
    end)
  end

  defp valid?(part, [test, [a | rest]]) do
    compute part, test, rest, a
  end

  defp compute(_part, test, [], acc) when test == acc, do: true

  defp compute(_part, _test, [], _acc), do: false

  defp compute(:p1, test, [b | rest], acc) do
    compute(:p1, test, rest, acc + b) || compute(:p1, test, rest, acc * b)
  end

  defp compute(:p2, test, [b | rest], acc) do
    compute(:p2, test, rest, acc + b) ||
    compute(:p2, test, rest, acc * b) ||
    compute(:p2, test, rest, concat_operator(acc, b))
  end

  defp concat_operator(a, b) do
    String.to_integer(Integer.to_string(a) <> Integer.to_string(b))
  end

  defp sum_of_equations(equations) do
    Enum.reduce(equations, 0, fn [test, _numbers], acc -> acc + test end)
  end
end

# -----

input_test = """
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
"""

{_, input} = File.read "./files/day07_input.txt"

IO.puts "--------------------------------------------------"

IO.puts "Part1 :: Test :: Result = #{Day07.part1(input_test)}"
IO.puts "Part1 :: Result = #{Day07.part1(input)}"

IO.puts "--------------------------------------------------"

IO.puts "Part2 :: Test :: Result = #{Day07.part2(input_test)}"
IO.puts "Part2 :: Result = #{Day07.part2(input)}"

IO.puts "--------------------------------------------------"
