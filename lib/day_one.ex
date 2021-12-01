defmodule Aoc.DayOne do

  def part_one(file_path) do
    input = InputReader.get_lines_integer(file_path)
    [first_element | rest] = input
    count_diff(first_element, rest, 0)
  end

  def part_two(file_path) do
    input = InputReader.get_lines_integer(file_path)
    count_sliding_3(input, 0)
  end

  defp count_diff(prev, [list], count) when list - prev > 0, do: count + 1
  defp count_diff(prev, [first | list], count) when first - prev > 0, do: count_diff(first, list, count + 1)
  defp count_diff(_prev, [first | list], count), do: count_diff(first, list, count)

  defp count_sliding_3([a1, a2, a3, a4 | rest], count) do
    sum1 = a1 + a2 + a3
    sum2 = a2 + a3 + a4
    if (sum2 - sum1) > 0 do
      count_sliding_3([a2, a3, a4 | rest], count + 1)
    else
      count_sliding_3([a2, a3, a4 | rest], count)
    end
  end

  defp count_sliding_3(_, count), do: count
end
