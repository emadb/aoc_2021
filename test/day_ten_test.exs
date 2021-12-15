defmodule Aoc.DayTenTest do
  use ExUnit.Case
  @day 10
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayTen.part_one(input)

    assert result == 26397
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayTen.part_one(input)
    assert result == 166_191
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayTen.part_two(input)

    assert result == 288_957
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayTen.part_two(input)

    assert result == 1_152_088_313
  end
end
