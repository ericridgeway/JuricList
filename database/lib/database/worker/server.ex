defmodule Database.Worker.Server do
  use GenServer

  alias Database.Worker.{Impl}

  @impl GenServer
  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  @impl GenServer
  def handle_call({:store, key, data}, _from, state) do
    state
    |> Impl.store(key, data)
    |> reply(:ok)
  end

  @impl GenServer
  def handle_call({:delete, key}, _from, state) do
    state
    |> Impl.delete(key)
    |> reply(:ok)
  end


  @impl GenServer
  def handle_call({:get, key}, _from, state) do
    with data <- Impl.get(state, key)
    do
      state
      |> reply(data)
    end
  end


  defp reply(state, msg) do
    {:reply, msg, state}
  end
end
