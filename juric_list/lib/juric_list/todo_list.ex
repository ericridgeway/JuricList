defmodule JuricList.TodoList do
  import ShorterMaps

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

  def update_entry(~M{entries} = todo_list, id, updater_fun) do
    new_entry = updater_fun.(todo_list.entries[id])
    new_entries = Map.put(todo_list.entries, id, new_entry)

    %TodoList{todo_list | entries: new_entries}
  end
end
