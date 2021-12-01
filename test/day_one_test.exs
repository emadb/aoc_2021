defmodule Aoc.DayOneTest do
  use ExUnit.Case
  @day 1
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayOne.part_one(input)

    assert result == 7
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayOne.part_one(input)
    assert result == 1722
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayOne.part_two(input)

    assert result == 5
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayOne.part_two(input)

    assert result == 1748
  end
end
