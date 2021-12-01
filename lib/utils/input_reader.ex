defmodule InputReader do

  def get_lines_integer(file_path) do
    file_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn i ->
      {n, _} = Integer.parse(i)
      n
    end)
  end

  def get_lines_string(file_path) do
    file_path
    |> File.read!()
    |> String.split("\n")
  end

end
