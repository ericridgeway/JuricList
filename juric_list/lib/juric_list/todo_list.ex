defmodule JuricList.TodoList do

  alias JuricList.{MapOfLists}

  def new() do
    MapOfLists.new()
  end

  def add_entry(todo_list, entry) do
    MapOfLists.update(todo_list, entry.date, entry)
  end

  def titles(todo_list, date) do
    MapOfLists.get_list(todo_list, date)
    |> just_titles_from_entries_list()
  end


  defp just_titles_from_entries_list(entries_list) do
    entries_list
    |> Enum.reduce([], fn (%{title: title}, list) -> [title | list] end)
    |> Enum.reverse()
  end
end
