defmodule Cache.Server do
  use GenServer

  alias Cache.{Impl}

  @impl GenServer
  def init(_init_arg) do
    # TODO temp "hack", eventually book will have us switch to Application supervisor start stuff I assume
    Database.start()

    {:ok, Impl.new()}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _from, state) do
    with state <- Impl.put_if_doesnt_exist(state, todo_list_name),
         todo_server <- Impl.get(state, todo_list_name)
    do
      state
      |> reply(todo_server)
    end
  end


  defp reply(state, msg) do
    {:reply, msg, state}
  end
end
