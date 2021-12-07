defmodule Aoc.DaySevenTest do
  use ExUnit.Case
  @day 7
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DaySeven.part_one(input)

    assert result == 37
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DaySeven.part_one(input)
    assert result == 344535
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DaySeven.part_two(input)

    assert result == 168
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DaySeven.part_two(input)

    assert result == 95581659
  end
end
