defmodule Aoc.DayFourTest do
  use ExUnit.Case
  @day 4
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayFour.part_one(input)

    assert result == 4512
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayFour.part_one(input)
    assert result == 6592
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayFour.part_two(input)

    assert result == 1924
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayFour.part_two(input)

    assert result == 31755
  end
end
