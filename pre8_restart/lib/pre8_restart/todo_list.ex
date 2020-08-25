defmodule Pre8Restart.TodoList do

  @type t :: %{id => entry}
  @type id :: pos_integer
  @type entry :: %{id: id, date: date, title: title}
  @type date :: Calendar.date
  @type title :: String.t

  @spec new() :: t
  def new() do
    %{}
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
