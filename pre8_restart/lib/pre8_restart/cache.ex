defmodule Pre8Restart.Cache do
  alias Pre8Restart.{TodoList, Database}

  @type t :: %{name => todo_list}
  @type name :: String.t
  @type todo_list :: TodoList.t

  @spec new() :: t
  # defdelegate new(), to: Map
  def new() do
    # NOTE tmp hack book asks for, pg 191
    Database.start()

    %{}
  end

  @spec put_if_doesnt_exist(t, name) :: t
  def put_if_doesnt_exist(state, name) do
    Map.put_new_lazy(state, name, fn ->
      TodoList.new()
    end)
  end

  @spec get(t, name) :: todo_list
  defdelegate get(state, name), to: Map
end
