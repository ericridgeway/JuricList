defmodule JuricList.TodoList do
  import ShorterMaps

  alias JuricList.{MapOfLists, TodoList}

  defstruct auto_id: 1, entries: %{}

  def new() do
    %TodoList{}
  end

  def add_entry(~M{auto_id, entries} = todo_list, entry) do
    entry = Map.put(entry, :id, auto_id)
    entries = Map.put(entries, auto_id, entry)
    auto_id = auto_id + 1

    ~M{%TodoList todo_list | entries, auto_id}
  end

  # TODO delete MapOfLists, no longer needed (we're storing a simpler map of entries, not a map of growing lists in the values
  def titles(todo_list, target_date) do
    todo_list.entries
    |> Enum.filter(fn ({_id, %{date: date}}) -> date == target_date end)
    |> Enum.map(fn ({_id, %{title: title}}) -> title end)
  end

  def update_entry(~M{entries} = todo_list, id, updater_fun) do
    entry = updater_fun.(entries[id])
    entries = Map.put(entries, id, entry)

    ~M{%TodoList todo_list | entries}
  end
end
