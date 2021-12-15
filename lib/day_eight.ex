defmodule Aoc.DayEight do
  def part_one(file_path) do
    input = InputReader.get_lines_string(file_path)

    input
    |> Enum.flat_map(fn l ->
      [_, od] = String.split(l, " | ")
      parse_digits_length(od)
    end)
    |> Enum.reduce(%{}, fn x, acc -> decode_digit(x, acc) end)
    |> Map.values()
    |> Enum.sum()
  end

  def part_two(file_path) do
    InputReader.get_lines_string(file_path)
    |> Enum.map(fn line ->
      String.split(line, "|", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> List.to_tuple()
    end)
    |> Enum.map(&process_line/1)
    |> Enum.sum()
  end

  defp process_line({input, output}) do
    output
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&decode_string(&1, input))
    |> Integer.undigits()
  end

  defp decode_string(string, input) do
    n1 = Enum.find(input, &(String.length(&1) == 2)) |> String.to_charlist()
    n4 = Enum.find(input, &(String.length(&1) == 4)) |> String.to_charlist()

    case length(string) do
      2 ->
        1

      3 ->
        7

      4 ->
        4

      5 ->
        case length(string -- n1) do
          3 ->
            3

          _ ->
            case length(string -- n4) do
              3 -> 2
              _ -> 5
            end
        end

      6 ->
        case length(string -- n1) do
          5 ->
            6

          _ ->
            case length(string -- n4) do
              2 -> 9
              _ -> 0
            end
        end

      7 ->
        8
    end
  end

  defp parse_digits_length(od) do
    od
    |> String.split(" ")
    |> Enum.reduce([], fn d, acc -> acc ++ [String.length(d)] end)
  end

  defp decode_digit(d, acc) do
    case d do
      2 -> Map.update(acc, "2", 1, &(&1 + 1))
      3 -> Map.update(acc, "3", 1, &(&1 + 1))
      4 -> Map.update(acc, "4", 1, &(&1 + 1))
      7 -> Map.update(acc, "7", 1, &(&1 + 1))
      _ -> acc
    end
  end
end
