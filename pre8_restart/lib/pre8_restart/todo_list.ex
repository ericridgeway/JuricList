defmodule Pre8Restart.TodoList do
  alias __MODULE__

  defstruct [:auto_id, :entries]

  @type t :: %TodoList{auto_id: id, entries: entries}
  @type id :: pos_integer
  @type entries :: %{id => entry}
  @type entry :: %{id: id, date: date, title: title}
  # @type date :: Calendar.date
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
  def add_entry(todo_list, _entry) do
    todo_list
  end

  @spec titles(t, date) :: [title]
  def titles(_todo_list, _date) do
    []
  end
end
