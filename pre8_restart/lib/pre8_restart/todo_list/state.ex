defmodule Pre8Restart.TodoList.State do
  @type t :: %{auto_id: id, entries: entries}
  @type id :: pos_integer
  @type entries :: %{id => entry}
  @type entry :: %{id: id, date: date, title: title}
  @type date :: Date.t
  @type title :: String.t

  @spec new() :: t
  def new() do
    %{
      auto_id: 1,
      entries: %{},
    }
  end

  @spec add_entry(t, entry) :: t
  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %{todo_list |
      auto_id: todo_list.auto_id + 1,
      entries: entries,
    }
  end

  @spec titles(t, date) :: [title]
  def titles(todo_list, target_date) do
    entries(todo_list, target_date)
    |> Enum.map(& &1.title)
  end

  @spec entries(t, date) :: [entry]
  def entries(todo_list, target_date) do
    todo_list.entries
    |> Stream.map(fn {_id, entry} -> entry end)
    |> Enum.filter(& &1.date == target_date)
  end

  @spec update_entry(t, id, fun) :: t
  def update_entry(todo_list, id, updater_fun) do
    case Map.fetch(todo_list.entries, id) do
      {:ok, old_entry} ->
        updated_entry = updater_fun.(old_entry)

        validate_entry(old_entry, updated_entry)

        put_in(todo_list.entries[id], updated_entry)

      _ ->
        todo_list
    end
  end

  @spec update_entry(t, entry) :: t
  def update_entry(todo_list, updated_entry) do
    update_entry(todo_list, updated_entry.id, fn _ ->
      updated_entry
    end)
  end

  @spec delete_entry(t, id) :: t
  def delete_entry(todo_list, id) do
    update_in(todo_list.entries, fn entries ->
      Map.delete(entries, id)
    end)
  end


  @spec validate_entry(entry, entry) :: :ok
  defp validate_entry(old_entry, updated_entry) do
    %{} = updated_entry

    original_id = old_entry.id
    %{id: ^original_id} = updated_entry

    :ok
  end
end
