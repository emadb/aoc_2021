defmodule Aoc.DayFourteen do
  def part_one(file_path) do
    [input, "" | map] = InputReader.get_lines_string(file_path)

    map = build_map(map)
    input = String.graphemes(input)

    count = Enum.reduce(1..10, input, fn _, list ->
      list
      |> Enum.chunk_every(2, 1)
      |> Enum.flat_map(fn el -> apply_reducer(el, map) end)
    end)
    |> group_by()
    |> Map.values()

    Enum.max(count) - Enum.min(count)
  end




  defp build_map(map) do
    Enum.reduce(map, %{}, fn line, acc ->
      r = ~r/(?<left>[A-Z]{2})\s->\s(?<right>[A-Z])$/
      [_, left, right] = Regex.run(r, line)
      Map.put(acc, left, right)
    end)

  end

  defp group_by(list) do
    Enum.reduce(list, %{}, fn letter, acc ->
      Map.update(acc, letter, 1, &(&1 + 1))
    end)
  end

  defp apply_reducer([c], _) do
    [c]
  end
  defp apply_reducer([c1, c2], map) do
    [c1, map[c1 <> c2]]
  end

  def part_two(file_path) do
    [input, "" | map] = InputReader.get_lines_string(file_path)

    map = build_map(map)
    input = String.graphemes(input)

      input
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.frequencies()
      |> process(map, 40)
      |> calculate_result(hd(input))

  end

  defp calculate_result(frequencies, first) do
    {min, max} =
      frequencies
      |> Enum.reduce(%{first => 1}, fn {[_, e], amount}, map ->
        Map.put(map, e, Map.get(map, e, 0) + amount)
      end)
      |> Map.values()
      |> Enum.min_max()

    max - min
  end

  defp process(list, _, 0), do: list
  defp process(list, map, step) do
    Enum.reduce(list, %{}, fn x, acc -> update(x, acc, map) end)
    |> process(map, step - 1)
  end

  defp update({elements = [e1, e2], freq}, list, map) do
    key = Enum.join(elements)
    case Map.get(map, key) do
      nil ->
        Map.put(list, elements, freq)
      e ->
        list
        |> Map.put([e1, e], Map.get(list, [e1, e], 0) + freq)
        |> Map.put([e, e2], Map.get(list, [e, e2], 0) + freq)
    end
  end



end
