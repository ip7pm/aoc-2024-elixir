defmodule Matrix do

  def parse(input, opts \\ []) do
    defaults = [sep: "", to: :none]
    opts = Keyword.merge(defaults, opts) |> Enum.into(%{})
    parse input, opts.sep, opts.to
  end

  def parse(input, sep, :none), do: parse(input, sep, &(&1))

  def parse(input, sep, :int), do: parse(input, sep, &(String.to_integer(&1)))

  def parse(input, sep, :float), do: parse(input, sep, &(String.to_float(&1)))

  def parse(input, sep, fun) when is_function(fun) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn r ->
      String.split(r, sep, trim: true)
      |> Enum.map(&fun.(&1))
    end)
  end

  # -----

  def size(mat) do
    {length(mat), List.first(mat) |> length()}
  end

  def get(mat, {row, col}), do: get(mat, row, col)

  def get(mat, row, col) do
    {rows, cols} = size mat
    if row >= 0 and row < rows and col >= 0 and col < cols do
      Enum.at(mat, row) |> Enum.at(col)
    else
      nil
    end
  end

  def set(mat, {row, col}, value), do: set(mat, row, col, value)

  def set(mat, row, col, value) do
    vect = Enum.at mat, row
    new_vect = List.replace_at vect, col, value
    List.replace_at mat, row, new_vect
  end

  # -----

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
    |> Enum.map(fn i -> get(mat, row + i * dr, col + i * dc) end)
    |> Enum.filter(&(&1 != nil))
  end
end
