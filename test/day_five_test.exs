defmodule Aoc.DayFiveTest do
  use ExUnit.Case
  @day 5
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayFive.part_one(input)

    assert result == 5
  end

  @tag :skip
  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayFive.part_one(input)
    assert result == 7380
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayFive.part_two(input)

    assert result == 12
  end

  @tag timeout: :infinity
  @tag :skip
  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayFive.part_two(input)

    assert result == 21373
  end
end
