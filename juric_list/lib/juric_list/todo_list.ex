defmodule JuricList.TodoList do

  alias JuricList.{MapOfLists, TodoList}

  defstruct auto_id: 1, entries: %{}

  def new() do
    %TodoList{}
  end

  def add_entry(%{auto_id: auto_id, entries: entries} = todo_list, entry) do
    entry = Map.put(entry, :id, auto_id)
    entries = Map.put(entries, auto_id, entry)
    auto_id = auto_id + 1

    %TodoList{todo_list | entries: entries, auto_id: auto_id}
  end

  # TODO delete MapOfLists, no longer needed (we're storing a simpler map of entries, not a map of growing lists in the values
  # TODO shortermaps
  def titles(%{entries: entries} = todo_list, target_date) do
    entries
    |> Enum.filter(fn ({_id, %{date: date}}) -> date == target_date end)
    |> Enum.map(fn ({_id, %{title: title}}) -> title end)
  end
end
