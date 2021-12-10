defmodule Aoc.DayNine do

  def part_one(file_path) do
    input = file_path
    |> InputReader.get_lines_string()
    |> Enum.map(fn x -> String.graphemes(x) |> Enum.map(&String.to_integer/1) end)

    {r, c} = {Enum.count(input), Enum.count(Enum.at(input, 0))}
    coords = for y <- 0..r-1, x <- 0..c-1, do: {x, y}

    Enum.reduce(coords, [], fn {x, y}, acc ->
      case low?(x, y, input) do
        false -> acc
        n -> acc ++ [n]
      end
    end)
    |> Enum.map(fn x -> x + 1 end)
    |> Enum.sum()
  end


  defp low?(x, y, input) do
    ref_value = get_value(x, y, input)

    v1 = get_value(x-1, y, input)
    v2 = get_value(x+1, y, input)
    v3 = get_value(x, y-1, input)
    v4 = get_value(x, y+1, input)

    is_low =
      [v1, v2, v3, v4]
      |> Enum.all?(fn x -> ref_value < x end)

    if is_low do
      ref_value
    else
      false
    end

  end

  defp get_value(x, y, input) when x >= 0 and y >= 0 do
    case Enum.at(input, y, nil) do
      nil -> 9
      list ->
        case Enum.at(list, x, nil) do
          nil -> 9
          n -> n
        end
    end
  end

  defp get_value(_x, _y, _input), do: 9

  def part_two(file_path) do
    input = parse_input(file_path)
    coords = build_coordinate_list(input)
    lows = find_lows(coords, input)

    [p1, p2, p3 | _ ] = Enum.map(lows, fn low ->
      find_basin(low, input, [])
      |> Enum.uniq()
      |> Enum.count()
    end)
    |> Enum.sort(:desc)

    p1 * p2 * p3

  end

  defp find_basin({x, y}, map, list) do

    list
    |> check_cell({x + 1, y}, map)
    |> check_cell({x - 1, y}, map)
    |> check_cell({x, y + 1}, map)
    |> check_cell({x, y - 1}, map)

  end

  def check_cell(list, {x, y}, map) do
    if !visited?({x, y}, list) && get_value(x, y, map) != 9 do
      find_basin({x, y}, map, list ++ [{x, y}])
    else
      list
    end
  end

  def visited?({x, y}, list) do
    Enum.find(list, false, fn {a, b} -> a == x && b == y end) != false
  end

  def find_lows(coords, input) do
    Enum.reduce(coords, [], fn {x, y}, acc ->
      case low?(x, y, input) do
        false -> acc
        _ -> acc ++ [{x, y}]
      end
    end)
  end

  defp parse_input(file_path) do
    file_path
    |> InputReader.get_lines_string()
    |> Enum.map(fn x -> String.graphemes(x) |> Enum.map(&String.to_integer/1) end)
  end

  defp build_coordinate_list(input) do
    {r, c} = {Enum.count(input), Enum.count(Enum.at(input, 0))}
    for y <- 0..r-1, x <- 0..c-1, do: {x, y}
  end
end
