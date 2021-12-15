defmodule Aoc.DayTwo do
  import String

  def part_one(file_path) do
    input = InputReader.get_lines_string(file_path)
    {x, d} = move(input, {0, 0})
    x * d
  end

  def move(["forward " <> v | rest], {f, d}), do: move(rest, {f + to_integer(v), d})
  def move(["down " <> v | rest], {f, d}), do: move(rest, {f, d + to_integer(v)})
  def move(["up " <> v | rest], {f, d}), do: move(rest, {f, d - to_integer(v)})
  def move([], result), do: result

  def part_two(file_path) do
    input = InputReader.get_lines_string(file_path)
    {x, d, _} = move_2(input, {0, 0, 0})
    x * d
  end

  def move_2(["forward " <> v | rest], {f, d, a}),
    do: move_2(rest, {f + to_integer(v), d + a * to_integer(v), a})

  def move_2(["down " <> v | rest], {f, d, a}), do: move_2(rest, {f, d, a + to_integer(v)})
  def move_2(["up " <> v | rest], {f, d, a}), do: move_2(rest, {f, d, a - to_integer(v)})
  def move_2([], result), do: result
end
