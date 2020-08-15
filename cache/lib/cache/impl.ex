defmodule Cache.Impl do

  defdelegate new(), to: Map
  defdelegate fetch(map, key), to: Map

  def add_if_doesnt_exist(state, todo_list_name) do
    Map.put_new_lazy(state, todo_list_name, fn ->
      {:ok, new_server} = TodoServer.start()
      new_server
    end)
  end
end

