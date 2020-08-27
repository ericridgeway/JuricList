defmodule Pre8Restart.Cache do
  alias Pre8Restart.{TodoList, Database}

  @type t :: %{name => todo_list}
  @type name :: String.t
  @type todo_list :: TodoList.t

  @spec new() :: t
  # defdelegate new(), to: Map
  def new() do
    %{}
  end

  @spec put_if_doesnt_exist(t, name) :: t
  def put_if_doesnt_exist(state, name, database \\ nil) do
    Map.put_new_lazy(state, name, fn ->
      TodoList.new(name, database)
    end)
  end

  @spec get(t, name) :: todo_list
  defdelegate get(state, name), to: Map
end
