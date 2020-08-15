defmodule Cache.Server do
  use GenServer

  alias Cache.{Impl}

  @impl GenServer
  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, state) do
    with state <- Impl.add_if_doesnt_exist(state, todo_list_name),
         {:ok, todo_server} <- Impl.fetch(state, todo_list_name)
    do
      state
      |> reply(todo_server)
    else
      error -> reply(state, error)
    end
  end


  defp reply(state, msg) do
    {:reply, msg, state}
  end
end
