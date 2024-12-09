Code.require_file "./matrix.ex"

defmodule Day05 do

  def part1(input) do
    [rules, updates] = parse input
    filter_updates(rules, updates, &Enum.all?/1)
    |> sum_of_middle
  end

  def part2(input) do
    [rules, updates] = parse input
    filter_updates(rules, updates, fn u -> Enum.any?(u, &(&1 == false)) end)
    |> Enum.map(fn u ->
      Enum.sort u, fn a, b -> [a, b] in rules end
    end)
    |> sum_of_middle
  end

  defp parse(input) do
    [rules, updates] = String.split input, "\n\n"
    [Matrix.parse(rules, sep: "|", to: :int),
    Matrix.parse(updates, sep: ",", to: :int)]
  end

  defp sum_of_middle(updates) do
    updates
    |> Enum.map(fn u -> Enum.at u, trunc(length(u) / 2) end)
    |> Enum.sum()
  end

  defp filter_updates(rules, updates, fun) when is_function(fun) do
    updates
    |> Enum.filter(fn u ->
      Enum.chunk_every(u, 2, 1, :discard)
      |> Enum.map(fn p -> p in rules end)
      |> fun.()
    end)
  end
end

# -----

input_test = """
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
"""

{_, input} = File.read "./files/day05_input.txt"

IO.puts "--------------------------------------------------"

IO.puts "Part1 :: Test :: Result = #{Day05.part1(input_test)}"
IO.puts "Part1 :: Result = #{Day05.part1(input)}"

IO.puts "--------------------------------------------------"


IO.puts "Part2 :: Test :: Result = #{Day05.part2(input_test)}"
IO.puts "Part2 :: Result = #{Day05.part2(input)}"

IO.puts "--------------------------------------------------"
