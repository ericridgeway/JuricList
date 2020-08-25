defmodule Pre8Restart.TodoList do
  alias __MODULE__

  defstruct [:auto_id, :entries]

  @type t :: %TodoList{auto_id: id, entries: entries}
  @type id :: pos_integer
  @type entries :: %{id => entry}
  @type entry :: %{id: id, date: date, title: title}
  @type date :: Date.t
  @type title :: String.t

  @spec new() :: t
  def new() do
    %TodoList{
      auto_id: 1,
      entries: %{},
    }
  end

  @spec add_entry(t, entry) :: t
  def add_entry(todo_list, entry) do
    entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{todo_list |
      auto_id: todo_list.auto_id + 1,
      entries: entries,
    }
  end

  @spec titles(t, date) :: [title]
  def titles(todo_list, target_date) do
    todo_list.entries
    |> Enum.map(fn {_id, entry} -> entry end)
    |> Enum.filter(& &1.date == target_date)
    |> Enum.map(& &1.title)
    # |> Enum.map(fn _ -> 1234 end)
  end
end
