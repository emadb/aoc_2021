defmodule Aoc.DaySixTest do
  use ExUnit.Case
  @day 6
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DaySix.part_one(input)

    assert result == 5934
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DaySix.part_one(input)
    assert result == 356190
  end

  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DaySix.part_two(input)

    assert result == 26984457539
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DaySix.part_two(input)

    assert result == 1617359101538
  end
end
