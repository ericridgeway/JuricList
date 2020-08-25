defmodule Pre8Restart.TodoList do

  @type t :: %{id => entry}
  @type id :: pos_integer
  @type entry :: %{id: id, date: Date, title: title}
  @type title :: String.t

  @spec new() :: t
  def new() do
    # %{id: nil, entry: nil}
    # %{cat: :whatever}
    %{}
  end

  def add_entry(_todo_list, _entry) do
    -1
  end

  def titles(_todo_list, _date) do
    []
  end
end
