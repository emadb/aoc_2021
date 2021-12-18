defmodule Aoc.DayFourteenTest do
  use ExUnit.Case
  @day 14
  @fake_input "./test/fake_inputs/day_#{@day}.txt"
  @real_input "./lib/inputs/day_#{@day}.txt"

  test "part one (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayFourteen.part_one(input)

    assert result == 1588
  end

  test "part one" do
    input = Path.absname(@real_input)
    result = Aoc.DayFourteen.part_one(input)
    assert result == 2937
  end


  test "part two (fake)" do
    input = Path.absname(@fake_input)
    result = Aoc.DayFourteen.part_two(input)

    assert result == 2_188_189_693_529
  end

  test "part two" do
    input = Path.absname(@real_input)
    result = Aoc.DayFourteen.part_two(input)

    assert result == 3390034818249
  end
end
