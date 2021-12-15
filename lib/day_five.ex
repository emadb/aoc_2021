defmodule Aoc.DayFive do
  def part_one(file_path) do
    input = InputReader.get_lines_string(file_path)
    points = Enum.map(input, &parse_line/1)

    max_x = find_max_x(points)
    max_y = find_max_y(points)

    positions = build_map(max_x, max_y, points)
    count_overlaps(positions)
  end

  defp count_overlaps(positions) do
    Enum.count(positions, fn x -> x >= 2 end)
  end

  def build_map(max_x, max_y, points) do
    for x <- 0..max_x, y <- 0..max_y, do: count_points(x, y, points)
  end

  def count_points(x, y, points) do
    onx = Enum.count(points, &are_on_the_same_row(&1, {x, y}))
    ony = Enum.count(points, &are_on_the_same_column(&1, {x, y}))
    onx + ony
  end

  def are_on_the_same_row({{x1, y1}, {x2, y2}}, {x, y}) do
    y1 == y2 && y2 == y && ((x1 >= x && x2 <= x) || (x2 >= x && x1 <= x))
  end

  def are_on_the_same_column({{x1, y1}, {x2, y2}}, {x, y}) do
    x1 == x2 && x2 == x && ((y1 >= y && y2 <= y) || (y2 >= y && y1 <= y))
  end

  def find_max_x(points) do
    Enum.reduce(points, 0, fn {{x1, _}, {x2, _}}, acc -> max(x1, x2) |> max(acc) end)
  end

  def find_max_y(points) do
    Enum.reduce(points, 0, fn {{_, y1}, {_, y2}}, acc -> max(y1, y2) |> max(acc) end)
  end

  defp parse_line(line) do
    r = ~r/^(?<x1>\d*),(?<y1>\d*)\s->\s(?<x2>\d*),(?<y2>\d*)$/
    [_, x1, y1, x2, y2] = Regex.run(r, line)

    {{String.to_integer(x1), String.to_integer(y1)},
     {String.to_integer(x2), String.to_integer(y2)}}
  end

  def part_two(file_path) do
    input = InputReader.get_lines_string(file_path)
    points = Enum.map(input, &parse_line/1)

    max_x = find_max_x(points)
    max_y = find_max_y(points)

    positions = build_map_diagonal(max_x, max_y, points)
    count_overlaps(positions)
  end

  def build_map_diagonal(max_x, max_y, points) do
    max_xd = find_max_x(points)
    max_yd = find_max_y(points)

    diagonal_points =
      Enum.filter(points, fn {{x1, y1}, {x2, y2}} -> abs(x1 - x2) == abs(y1 - y2) end)

    for x <- 0..max_x, y <- 0..max_y do
      diagonal =
        if x < max_xd && y < max_yd do
          count_points_diagonal(x, y, diagonal_points)
        else
          0
        end

      count_points(x, y, points) + diagonal
    end
  end

  def count_points_diagonal(x, y, points) do
    Enum.count(points, &are_on_the_same_diagonal(&1, {x, y}))
  end

  def are_on_the_same_diagonal({{x1, y1}, {x2, y2}}, {x, y}) do
    dx = if x1 > x2, do: -1, else: 1
    dy = if y1 > y2, do: -1, else: 1

    is_diagonal?({{x1, y1}, {x2, y2}}, dx, dy, {x, y})
  end

  defp is_diagonal?({{x1, y1}, {x2, y2}}, dx, dy, {x, y}) do
    if x1 == x && y1 == y do
      true
    else
      if x1 == x2 && y1 == y2 do
        false
      else
        is_diagonal?({{x1 + dx, y1 + dy}, {x2, y2}}, dx, dy, {x, y})
      end
    end
  end
end
