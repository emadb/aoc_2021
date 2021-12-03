defmodule Aoc.DayThreeTest do
  use ExUnit.Case
  @day 3
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayThree.part_one(input)

    assert result == 198
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayThree.part_one(input)
    assert result == 841526
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayThree.part_two(input)

    assert result == 230
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayThree.part_two(input)

    assert result == 4790390
  end
end
