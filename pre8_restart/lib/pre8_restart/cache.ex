defmodule Pre8Restart.Cache do
  alias Pre8Restart.{TodoList}
  alias Pre8Restart.Database.{NothingDb}

  @type t :: %{name => todo_list}
  @type name :: String.t
  @type todo_list :: TodoList.t

  @spec new() :: t
  # defdelegate new(), to: Map
  def new() do
    %{}
  end

  # SOMEDAY not sure why this doesn't error. Anyways, pass in the new DbBehaviour module or something. Get to this later. Double check why this is in multiple places, cache and server... Maybe just getting passed down the line. Still prob need to alias in some @type or something, or doc what this should be
  @spec put_if_doesnt_exist(t, name) :: t
  def put_if_doesnt_exist(state, name, database \\ NothingDb) do
    Map.put_new_lazy(state, name, fn ->
      TodoList.new(name, database)
    end)
  end

  @spec get(t, name) :: todo_list
  defdelegate get(state, name), to: Map
end
