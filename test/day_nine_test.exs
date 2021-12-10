defmodule Aoc.DayNineTest do
  use ExUnit.Case
  @day 9
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayNine.part_one(input)

    assert result == 15
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayNine.part_one(input)
    assert result == 506
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayNine.part_two(input)

    assert result == 1134
  end


  @tag timeout: :infinity
  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayNine.part_two(input)

    assert result == 1043697
  end
end
