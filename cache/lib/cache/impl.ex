defmodule Cache.Impl do

  defdelegate new(), to: Map
  defdelegate fetch(map, key), to: Map
  defdelegate put(map, key, value), to: Map

  def get_existing_or_make_new(state, todo_list_name) do
    case fetch(state, todo_list_name) do
      {:ok, todo_server} ->
        {state, todo_server}

      _ ->
        {:ok, new_server} = TodoServer.start()
        new_state = put(state, todo_list_name, new_server)

        {new_state, new_server}
    end
  end
end

