defmodule Aoc.DaySix do
  def part_one(file_path) do
    input =
      InputReader.get_line(file_path)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    progress(80, input)
    |> Map.values()
    |> Enum.sum()
  end

  def progress(0, input), do: input

  def progress(n, input) do
    new_input =
      Enum.reduce(input, %{}, fn {k, num}, acc ->
        case k do
          0 ->
            acc
            |> Map.put(8, num)
            |> Map.update(6, num, fn x -> num + x end)

          _ ->
            Map.update(acc, k - 1, num, fn x -> num + x end)
        end
      end)

    progress(n - 1, new_input)
  end

  def part_two(file_path) do
    input =
      InputReader.get_line(file_path)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    progress(256, input)
    |> Map.values()
    |> Enum.sum()
  end
end
