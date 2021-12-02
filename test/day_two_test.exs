defmodule Aoc.DayTwoTest do
  use ExUnit.Case
  @day 2
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayTwo.part_one(input)

    assert result == 150
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayTwo.part_one(input)
    assert result == 1815044
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayTwo.part_two(input)

    assert result == 900
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayTwo.part_two(input)

    assert result == 1739283308
  end
end
