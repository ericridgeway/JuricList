defmodule Pre8Restart.Cache do
  alias Pre8Restart.{TodoList}

  @type t :: %{}
  @type name :: String.t

  @spec new() :: t
  def new() do
    %{}
  end

  @spec fetch_list(t, name) :: TodoList.t
  def fetch_list(state, name) do
    TodoList.new()
  end
end
