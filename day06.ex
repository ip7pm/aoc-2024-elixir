Code.require_file "./matrix.ex"

defmodule Day06 do

  @steps [{-1, 0}, {0, 1}, {1, 0}, {0, -1}]

  def part1(input) do
    [last_map, _, _] = move init_state(input)
    length(Matrix.positions last_map, "X")
  end

  def part2(input) do
    state = init_state input
    [_, start_pos, start_step] = state
    last_state = move state
    [last_map, _, _] = last_state
    modified_map = Matrix.set last_map, start_pos, "."
    Matrix.positions(modified_map, "X")
    |> Enum.map(fn pos ->
      new_map = Matrix.set modified_map, pos, "#"
      loop? [new_map, start_pos, start_step, MapSet.new]
    end)
    |> Enum.count(&(&1))
  end

  defp init_state(input) do
    map = Matrix.parse input
    [start_pos] = Matrix.positions map, "^"
    start_step = List.first @steps
    new_map = Matrix.set map, start_pos, "X"
    [new_map, start_pos, start_step]
  end

  defp move(state) do
    [map, pos, step] = state
    next_pos = next_pos pos, step
    char = Matrix.get map, next_pos
    case char do
      nil -> state
      "#" ->
        move [map, pos, next_step(step)]
      _ ->
        new_map = Matrix.set map, next_pos, "X"
        move [new_map, next_pos, step]
    end
  end

  defp loop?(state) do
    [map, pos, step, path] = state
    next_pos = next_pos pos, step
    char = Matrix.get map, next_pos
    if MapSet.member? path, {next_pos, step} do
      true
    else
      case char do
        nil -> false
        "#" ->
          loop? [map, pos, next_step(step), path]
        _ ->
          new_map = Matrix.set map, next_pos, "X"
          loop? [new_map, next_pos, step, MapSet.put(path, {next_pos, step})]
      end
    end
  end

  defp next_pos({row, col}, {dr, dc}), do: {row + dr, col + dc}

  defp next_step(step) do
    idx = Enum.find_index @steps, &(&1 == step)
    Enum.at @steps, rem(idx + 1, 4)
  end
end

# -----

input_test = """
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
"""

{_, input} = File.read "./files/day06_input.txt"

IO.puts "--------------------------------------------------"

IO.puts "Part1 :: Test :: Result = #{Day06.part1(input_test)}"
IO.puts "Part1 :: Result = #{Day06.part1(input)}"

IO.puts "--------------------------------------------------"

IO.puts "Part2 :: Test :: Result = #{Day06.part2(input_test)}"
IO.puts "Part2 :: Result = #{Day06.part2(input)}"

IO.puts "--------------------------------------------------"
