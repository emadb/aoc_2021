defmodule Aoc.DayTen do
  @score1 %{
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }

  @matches %{
    ")" => "(",
    "]" => "[",
    "}" => "{",
    ">" => "<"
  }

  def part_one(file_path) do
    input = InputReader.get_lines_string(file_path)

    Enum.map(input, fn line ->
      res =
        String.graphemes(line)
        |> Enum.reduce_while(Stack.new(), fn x, acc ->
          acc =
            case x do
              "(" ->
                {:cont, Stack.push(acc, x)}

              "[" ->
                {:cont, Stack.push(acc, x)}

              "{" ->
                {:cont, Stack.push(acc, x)}

              "<" ->
                {:cont, Stack.push(acc, x)}

              close ->
                {open, acc} = Stack.pop(acc)

                if @matches[close] == open do
                  {:cont, acc}
                else
                  {:halt, @score1[close]}
                end
            end

          acc
        end)

      if Stack.is_stack?(res) do
        0
      else
        res
      end
    end)
    |> Enum.sum()
  end

  def part_two(file_path) do
    input = InputReader.get_lines_string(file_path)

    score2 = %{
      "(" => 1,
      "[" => 2,
      "{" => 3,
      "<" => 4
    }

    final_list =
      Enum.map(input, fn line ->
        res =
          String.graphemes(line)
          |> Enum.reduce_while(Stack.new(), fn x, acc ->
            acc =
              case x do
                "(" ->
                  {:cont, Stack.push(acc, x)}

                "[" ->
                  {:cont, Stack.push(acc, x)}

                "{" ->
                  {:cont, Stack.push(acc, x)}

                "<" ->
                  {:cont, Stack.push(acc, x)}

                close ->
                  {open, acc} = Stack.pop(acc)

                  if @matches[close] == open do
                    {:cont, acc}
                  else
                    {:halt, 0}
                  end
              end

            acc
          end)

        if Stack.is_stack?(res) do
          list = Stack.all(res)

          Enum.reduce(list, 0, fn x, acc ->
            acc * 5 + score2[x]
          end)
        else
          0
        end
      end)
      |> Enum.reject(fn x -> x == 0 end)
      |> Enum.sort()

    Enum.at(final_list, div(length(final_list), 2))
  end
end

defmodule Stack do
  defstruct elements: []

  def new, do: %Stack{}

  def is_stack?(%Stack{}), do: true
  def is_stack?(_), do: false

  def push(stack, element) do
    %Stack{stack | elements: [element | stack.elements]}
  end

  def pop(%Stack{elements: []}), do: raise("Stack is empty!")

  def pop(%Stack{elements: [top | rest]}) do
    {top, %Stack{elements: rest}}
  end

  def depth(%Stack{elements: elements}), do: length(elements)
  def all(%Stack{elements: elements}), do: elements
end
