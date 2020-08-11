defmodule JuricList.CsvImporter do

  def import(file) do
    file
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> IO.inspect(label: "1")
    # |> Enum.map(fn a -> a end)
    # |> IO.inspect(label: "asd")
  end
end
