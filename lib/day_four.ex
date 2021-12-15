defmodule Aoc.DayFour do
  def part_one(file_path) do
    [draw_numbers, "" | card_lines] = InputReader.get_lines_string(file_path)

    cards = build_cards(card_lines)

    draw_numbers
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce_while(cards, fn n, acc ->
      new_cards = mark_numbers(acc, n)
      check_result = check_winner(new_cards)

      case Enum.find(check_result, fn x -> x != 0 end) do
        nil -> {:cont, new_cards}
        m -> {:halt, n * m}
      end
    end)
  end

  def part_two(file_path) do
    [draw_numbers, "" | card_lines] = InputReader.get_lines_string(file_path)

    cards = build_cards(card_lines) |> Enum.map(fn c -> {0, 0, c} end)

    numbers =
      draw_numbers
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    final = play(numbers, cards)
    {_, n, card} = Enum.max_by(final, fn {w, _, _} -> w end)

    sum =
      card
      |> Enum.reject(fn {_, h} -> h == 1 end)
      |> Enum.reduce(0, fn {x, 0}, acc -> acc + x end)

    n * sum
  end

  defp play([n | rest], cards) do
    {max, _, _} = Enum.max_by(cards, fn {w, _, _} -> w end)

    next_cards =
      Enum.map(cards, fn {w, nn, card} ->
        if w > 0 do
          {w, nn, card}
        else
          new_card = Enum.map(card, fn c -> mark(c, n) end)

          case [rows(new_card), columns(new_card)] do
            [false, false] -> {0, 0, new_card}
            [_, _] -> {max + 1, n, new_card}
          end
        end
      end)

    play(rest, next_cards)
  end

  defp play([], cards), do: cards

  defp check_winner(cards) do
    Enum.map(cards, fn c ->
      case [rows(c), columns(c)] do
        [false, false] ->
          0

        [_, _] ->
          Enum.filter(c, fn {_, t} -> t == 0 end) |> Enum.reduce(0, fn {x, 0}, acc -> x + acc end)
      end
    end)
  end

  defp rows(card) do
    card
    |> Enum.chunk_every(5)
    |> Enum.map(fn line ->
      Enum.count(line, fn {_, v} -> v == 1 end)
    end)
    |> Enum.any?(fn x -> x == 5 end)
  end

  def columns(card) do
    FF.transpose(card)
    |> Enum.chunk_every(5)
    |> Enum.map(fn line ->
      Enum.count(line, fn {_, v} -> v == 1 end)
    end)
    |> Enum.any?(fn x -> x == 5 end)
  end

  defp mark_numbers(cards, n) do
    Enum.map(cards, fn card ->
      Enum.map(card, fn c -> mark(c, n) end)
    end)
  end

  defp mark({x, _}, n) when x == n, do: {x, 1}
  defp mark({x, k}, _), do: {x, k}

  defp build_cards(lines) do
    lines
    |> Enum.reject(&(&1 == ""))
    |> Enum.chunk_every(5)
    |> Enum.map(fn x -> Enum.join(x, " ") end)
    |> Enum.map(fn line ->
      line
      |> String.replace("  ", " ")
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(fn x -> {String.to_integer(x), 0} end)
    end)
  end
end

defmodule FF do
  def get_column_0(r), do: Enum.take_every(r, 5)
  def get_column_1([_ | r]), do: Enum.take_every(r, 5)
  def get_column_2([_, _ | r]), do: Enum.take_every(r, 5)
  def get_column_3([_, _, _ | r]), do: Enum.take_every(r, 5)
  def get_column_4([_, _, _, _ | r]), do: Enum.take_every(r, 5)

  def transpose(card) do
    Enum.flat_map(
      [
        FF.get_column_0(card),
        FF.get_column_1(card),
        FF.get_column_2(card),
        FF.get_column_3(card),
        FF.get_column_4(card)
      ],
      fn x -> x end
    )
  end
end
