defmodule Aoc.DayThirtheen do
  def part_one(file_path) do
    input = InputReader.get_lines_string(file_path)

    {map, folds} = parse(input)
    [{xy, value} | _ ] = folds

    new_map = case xy do
      "x" -> Enum.map(map, fn {x, y} ->
        if (x > value) do
          {value - abs(x - value), y}
        else
          {x, y}
        end
      end)
      "y" -> Enum.map(map, fn {x, y} ->
        if (y > value) do
          {x, value - abs(y - value)}
        else
          {x, y}
        end
      end)
    end

    new_map
    |> Enum.uniq()
    |> Enum.count()



  end

  defp parse(input) do
    Enum.reduce(input, {[], []}, fn line, {map, folds} ->
      cond  do
        String.starts_with?(line, "fold along") ->
          r = ~r/^fold along (?<xy>[xy])=(?<v>\d+)$/
          [_, xy, v] = Regex.run(r, line)
          {map, folds ++ [{xy, String.to_integer(v)}]}
        line == "" ->
          {map, folds}
        true ->
          [x, y] = String.split(line, ",", trim: true)
          {map ++ [{String.to_integer(x), String.to_integer(y)}], folds}
      end
    end)
  end

  def part_two(file_path) do
    input = InputReader.get_lines_string(file_path)

    {map, folds} = parse(input)

    folded = Enum.reduce(folds, map, fn {xy, value}, current_map ->
      new_map = case xy do
        "x" -> Enum.map(current_map, fn {x, y} ->
          if (x > value) do
            {value - abs(x - value), y}
          else
            {x, y}
          end
        end)
        "y" -> Enum.map(current_map, fn {x, y} ->
          if (y > value) do
            {x, value - abs(y - value)}
          else
            {x, y}
          end
        end)
      end

      new_map
      |> Enum.uniq()
    end)

    {width, _} = Enum.max_by(folded, &elem(&1, 0))
    {_, height} = Enum.max_by(folded, &elem(&1, 1))

    grid = MapSet.new(folded)
    IO.puts("")
    for y <- 0..height do
      for x <- 0..width do
        if {x, y} in grid do
          IO.write(" # ")
        else
          IO.write("   ")
        end
      end

      IO.puts("")
    end
  end
end
