defmodule Aoc.DayElevenTest do
  use ExUnit.Case
  @day 11
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayEleven.part_one(input)

    assert result == 1656
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayEleven.part_one(input)
    assert result == 1642
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayEleven.part_two(input)

    assert result == 195
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayEleven.part_two(input)

    assert result == 320
  end
end
