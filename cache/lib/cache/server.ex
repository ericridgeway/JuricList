defmodule Cache.Server do
  use GenServer

  alias Cache.{Impl}

  @impl GenServer
  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, state) do
    {state, todo_server} = Impl.get_existing_or_make_new(state, todo_list_name)

    {:reply, todo_server, state}
  end
end

