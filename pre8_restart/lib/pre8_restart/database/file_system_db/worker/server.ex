defmodule Pre8Restart.Database.FileSystemDb.Worker.Server do
  use GenServer

  alias Pre8Restart.Database.FileSystemDb.Worker.{State}

  @impl GenServer
  def init(_init_arg) do
    {:ok, State.new()}
  end

  @impl GenServer
  def handle_call({:store, key, value}, _from, state) do
    state
    |> State.store(key, value)
    |> reply(:ok)
  end

  @impl GenServer
  def handle_call(:clear, _from, state) do
    state
    |> State.clear()
    |> end_process(:ok)
  end


  @impl GenServer
  def handle_call({:get, key}, _from, state) do
    state
    |> reply(State.get(state, key))
  end


  defp reply(state, msg) do
    {:reply, msg, state}
  end

  defp end_process(state, msg) do
    {:stop, :normal, msg, state}
  end
end
