defmodule Cache.Impl do

  defdelegate new(), to: Map
  defdelegate get(map, key), to: Map

  def put_if_doesnt_exist(state, todo_list_name) do
    Map.put_new_lazy(state, todo_list_name, fn ->
      {:ok, new_server} = TodoServer.start(todo_list_name)
      new_server
    end)
  end
end

