defmodule JuricList.CsvImporter do
  import ShorterMaps

  alias JuricList.{TodoList}

  def import(file) do
    file
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(&List.to_tuple/1)
    |> Enum.map(&make_entry/1)
    |> TodoList.new()
  end


  defp make_entry({date_string, title}) do
    {yyyy, mm, dd} =
      date_string
      |> String.split("/")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    {:ok, date} = Date.new(yyyy, mm, dd)
    ~M{date, title}
  end
end
