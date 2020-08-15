defmodule Cache.Impl do

  defdelegate new(), to: Map
  defdelegate fetch(map, key), to: Map
  defdelegate put(map, key, value), to: Map

  def add_if_doesnt_exist(state, todo_list_name) do
    case fetch(state, todo_list_name) do
      {:ok, _value} ->
        state

      _ ->
        {:ok, new_server} = TodoServer.start()
        put(state, todo_list_name, new_server)
    end
  end
end

