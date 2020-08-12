defmodule JuricList.CsvImporter do
  import ShorterMaps

  alias JuricList.{TodoList}

  def import(file_name) do
    file_name
    |> get_lines()
    |> split_date_and_title()
    |> make_entries()
    |> TodoList.new()
  end

  defp get_lines(file_name) do
    file_name
    |> File.stream!()
    |> Enum.map(&String.trim/1)
  end

  defp split_date_and_title(lines) do
    lines
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(&List.to_tuple/1)
  end

  defp make_entries(date_and_title_list) do
    date_and_title_list
    |> IO.inspect(label: "")
    |> convert_dates()
    |> IO.inspect(label: "")
    |> Enum.map(&make_entry/1)
  end

  defp convert_dates(date_and_title_list) do
    date_and_title_list
    |> Enum.map(&convert_date/1)
  end

  defp convert_date(asd) do
    asd
    |> IO.inspect(label: "asd")

  end
  # {convert_date(), title}

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
