defmodule Aoc.DayThirtheenTest do
  use ExUnit.Case
  @day 13
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayThirtheen.part_one(input)

    assert result == 17
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayThirtheen.part_one(input)
    assert result == 818
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayThirtheen.part_two(input)

  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayThirtheen.part_two(input)
#    "LRGPRECB"
  end
end
