defmodule Pre8Restart.TodoList do

  @type t :: %{id: id, entry: entry}
  @type id :: pos_integer
  @type entry :: %{id: id, date: Date, title: String.t}

  def new() do
    -1
  end
end
