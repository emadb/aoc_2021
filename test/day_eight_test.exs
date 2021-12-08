defmodule Aoc.DayEightTest do
  use ExUnit.Case
  @day 8
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayEight.part_one(input)

    assert result == 26
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayEight.part_one(input)
    assert result == 416
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayEight.part_two(input)

    assert result == 61229
  end


  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayEight.part_two(input)

    assert result == 1043697
  end
end
