defmodule Matrix do

  def parse(input, delim \\ "") do
    parse(input, fn elm -> elm end, delim)
  end

  # def parse(input, :int, delim \\ "") when is_binary(delim) do
  #   parse(input, fn elm -> String.to_ingeter(elm) end, delim)
  # end

  def parse(input, fun, delim) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn r ->
      String.split(r, delim, trim: true)
      |> Enum.map(&fun.(&1))
    end)
  end

  def size(mat) do
    {length(mat), List.first(mat) |> length()}
  end

  def at(mat, row, col) do
    {rows, cols} = size mat
    if row >= 0 and row < rows and col >= 0 and col < cols do
      Enum.at(mat, row) |> Enum.at(col)
    else
      nil
    end
  end

  def transpose(mat) do
    mat |> List.zip |> Enum.map(&Tuple.to_list/1)
  end

  def positions(mat, elm) do
    mat
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, i} ->
      row
      |> Enum.with_index()
      |> Enum.filter(fn {c, _} -> c == elm end)
        |> Enum.map(fn {_, j} -> {i, j} end)
    end)
  end

  def vect_by_step(mat, row, col, {dr, dc}, range) do
    range
    |> Enum.map(fn i -> at(mat, row + i * dr, col + i * dc) end)
    |> Enum.filter(&(&1 != nil))
  end
end
