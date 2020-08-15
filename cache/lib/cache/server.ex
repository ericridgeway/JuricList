defmodule Cache.Server do
  use GenServer

  alias Cache.{Impl}

  @impl GenServer
  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, state) do
    # state = Impl.add_if_doesnt_exist(state, todo_list_name)
    # todo_server = Impl.fetch!(state, todo_list_name)
    state
    |> Impl.add_if_doesnt_exist(todo_list_name)
    |> reply_with_process()
  end

  defp reply_with_process(state) do
    msg = Impl.fetch!(state, todo_list_name)
    {:reply, msg, state}
  end

  # defp reply(state, msg) do
  #   {:reply, msg, state}
  # end
end

  #   state
  #   |> Impl.add_if_doesnt_exist(todo_list_name)
  #   |> reply(Impl.fetch!(state, todo_list_name))
  # end


# e
