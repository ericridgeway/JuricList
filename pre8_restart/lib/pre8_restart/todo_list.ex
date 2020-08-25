defmodule Pre8Restart.TodoList do

  @type t :: %{id => entry}
  @type id :: pos_integer
  @type entry :: %{id: id, date: Date, title: String.t}

  @spec new() :: t
  def new() do
    # %{id: nil, entry: nil}
    # %{cat: :whatever}
    %{}
  end
end
