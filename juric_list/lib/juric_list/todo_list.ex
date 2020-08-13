defmodule JuricList.TodoList do
  import ShorterMaps

  alias JuricList.{TodoList}

  defstruct auto_id: 1, entries: %{}

  def new() do
    %TodoList{}
  end

  def new(entries_list) do
    Enum.reduce(entries_list, new(), fn (entry, todo_list) ->
      todo_list
      |> add_entry(entry)
    end)
  end

  def add_entry(~M{auto_id, entries} = todo_list, entry) do
    entry = Map.put(entry, :id, auto_id)
    entries = Map.put(entries, auto_id, entry)
    auto_id = auto_id + 1

    ~M{%TodoList todo_list | entries, auto_id}
  end

  def entries(todo_list, target_date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(& Map.get(&1, :date) == target_date )
  end

  def titles(todo_list, target_date) do
    entries(todo_list, target_date)
    |> Enum.map(&Map.get(&1, :title))
  end

  def update_entry(~M{entries} = todo_list, id, updater_fun) do
    case Map.fetch(entries, id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        entry =
          updater_fun.(old_entry)
          |> validate_entry(id)

        entries = Map.put(entries, id, entry)

        ~M{%TodoList todo_list | entries}
    end
  end

  def delete_entry(todo_list, id) do
    todo_list
    |> pop_in([Access.key(:entries), Access.key(id)])
    |> elem(1)
  end


  defp validate_entry(entry, orig_id) do
    %{} = entry

    %{id: ^orig_id} = entry
  end
end
