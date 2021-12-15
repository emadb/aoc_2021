defmodule Aoc.DaySeven do
  def part_one(file_path) do
    find_min_movement(file_path, fn a, b -> abs(a - b) end)
  end

  def part_two(file_path) do
    find_min_movement(file_path, fn a, b -> prog_sum(a, b) end)
  end

  defp prog_sum(a, b) do
    n = abs(a - b)
    div(n * (n + 1), 2)
  end

  defp find_min_movement(file_path, dist_fn) do
    input = InputReader.get_line_integer(file_path)
    min_n = Enum.min(input)
    max_n = Enum.max(input)

    min_n..max_n
    |> Enum.map(fn n ->
      input
      |> Enum.map(fn x -> dist_fn.(n, x) end)
      |> Enum.sum()
    end)
    |> Enum.min()
  end
end
