defmodule Cache.Server do
  use GenServer

  alias Cache.{Impl}

  @impl GenServer
  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, state) do
    state = Impl.add_if_doesnt_exist(state, todo_list_name)
    todo_server = Impl.fetch!(state, todo_list_name)

    {:reply, todo_server, state}
  end
end
