defmodule Aoc.DayTwo do
  import String

  def part_one(file_path) do
    input = InputReader.get_lines_string(file_path)
    {x, d} = Enum.reduce(input, {0, 0}, &next_value_p1/2)
    x * d
  end

  def next_value_p1("forward " <> v, {f, d}), do: {f + to_integer(v), d}
  def next_value_p1("down " <> v, {f, d}), do: {f, d + to_integer(v)}
  def next_value_p1("up " <> v, {f, d}), do: {f, d - to_integer(v)}

  def part_two(file_path) do
    input = InputReader.get_lines_string(file_path)
    {x, d, _} = Enum.reduce(input, {0, 0, 0}, &next_value_p2/2)
    x * d
  end

  def next_value_p2("forward " <> v, {f, d, a}), do: {f + to_integer(v), d + (a * to_integer(v)), a}
  def next_value_p2("down " <> v, {f, d, a}), do: {f, d, a + to_integer(v)}
  def next_value_p2("up " <> v, {f, d, a}), do: {f, d, a - to_integer(v)}
end
