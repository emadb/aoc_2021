defmodule Aoc.DayEleven do
  def part_one(file_path) do
    lines = InputReader.get_lines_string(file_path)

    grid = to_map(lines)

    1..100
    |> Enum.map_reduce(grid, fn _, grid ->
      step(grid)
    end)
    |> elem(0)
    |> Enum.sum()
  end

  def step(grid) do
    flash(Map.keys(grid), grid, MapSet.new())
  end

  defp flash([{row, col} = key | keys], grid, flashed) do
    value = grid[key]

    cond do
      is_nil(value) or key in flashed ->
        flash(keys, grid, flashed)

      grid[key] >= 9 ->

        keys = neighbords({row, col}) ++ keys
        flash(keys, Map.put(grid, key, 0), MapSet.put(flashed, key))

      true ->
        flash(keys, Map.put(grid, key, value + 1), flashed)
    end
  end

  defp flash([], grid, flashed) do
    {MapSet.size(flashed), grid}
  end


  defp neighbords({x, y}) do
    [{x - 1, y - 1},
    {x - 1, y},
    {x - 1, y + 1},
    {x, y - 1},
    {x, y + 1},
    {x + 1, y - 1},
    {x + 1, y},
    {x + 1, y + 1}]
  end

  def part_two(file_path) do
    lines = InputReader.get_lines_string(file_path)

    grid = to_map(lines)

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(grid, fn i, grid ->
      case step(grid) do
        {flashes, grid} when map_size(grid) == flashes -> {:halt, i}
        {_flashes, grid} -> {:cont, grid}
      end
    end)
  end

  defp to_map(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
  end

  defp add_row({row, y}, map) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(map, fn {v, x}, m -> Map.put(m, {x, y}, String.to_integer(v)) end)
  end
end
