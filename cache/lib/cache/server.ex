defmodule Cache.Server do
  use GenServer

  alias Cache.{Impl}

  @impl GenServer
  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, state) do

    case Impl.fetch(state, todo_list_name) do
      {:ok, todo_server} ->
        {:reply, todo_server, state}

      _ ->
        {:ok, new_server} = TodoServer.start()
        new_state = Impl.put(state, todo_list_name, new_server)

        {:reply, new_server, new_state}
    end
  end
end

