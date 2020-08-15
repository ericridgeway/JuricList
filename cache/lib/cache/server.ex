defmodule Cache.Server do
  use GenServer

  alias Cache.{Impl}

  @impl GenServer
  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, state) do
    {:ok, new_server} = TodoServer.start()
    new_state = Impl.put(state, todo_list_name, new_server)

    {:reply, new_server, new_state}

    # case Impl.fetch(state, todo_list_name) do
    #   _ ->
    #     {:reply, -1, state}
    # end
  end
end

