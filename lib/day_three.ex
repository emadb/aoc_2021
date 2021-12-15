defmodule Aoc.DayThree do
  def part_one(file_path) do
    input =
      InputReader.get_lines_string(file_path)
      |> transpose()
      |> Enum.map(fn l ->
        {Enum.count(l, &(&1 == "0")), Enum.count(l, &(&1 == "1"))}
      end)

    count_occurrence(input, &zero?/1) * count_occurrence(input, &one?/1)
  end

  defp count_occurrence(input, fn_0) do
    input
    |> Enum.map(fn x -> fn_0.(x) end)
    |> Enum.join("")
    |> String.to_integer(2)
  end

  defp zero?({z, o}), do: if(z > o, do: 0, else: 1)
  defp one?({z, o}), do: if(z < o, do: 0, else: 1)

  defp transpose(input) do
    input
    |> Enum.map(fn x -> String.graphemes(x) end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def part_two(file_path) do
    input = InputReader.get_lines_string(file_path)

    l = Enum.at(input, 0) |> String.length()
    [res1] = process(0..(l - 1), input, &greater_or_equal/2)
    [res0] = process(0..(l - 1), input, &less/2)

    String.to_integer(res1, 2) * String.to_integer(res0, 2)
  end

  defp greater_or_equal(a, b), do: a >= b
  defp less(a, b), do: a < b

  defp process(range, input, cmp) do
    range
    |> Enum.reduce_while(input, fn i, acc ->
      count_1 =
        Enum.reduce(acc, 0, fn x, acc ->
          bit = x |> String.graphemes() |> Enum.at(i) |> String.to_integer()
          bit + acc
        end)

      rest = if cmp.(count_1 * 2, Enum.count(acc)), do: filter_1(i, acc), else: filter_0(i, acc)
      continue?(rest)
    end)
  end

  defp filter_1(i, input) do
    Enum.filter(input, fn x -> String.at(x, i) == "1" end)
  end

  defp filter_0(i, input) do
    Enum.filter(input, fn x -> String.at(x, i) == "0" end)
  end

  defp continue?(input) do
    if Enum.count(input) > 1, do: {:cont, input}, else: {:halt, input}
  end
end
