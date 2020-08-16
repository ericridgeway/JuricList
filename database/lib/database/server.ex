defmodule Database.Server do
  use GenServer

  alias Database.{Impl}

  @impl GenServer
  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  @impl GenServer
  def handle_cast({:store, key, data}, state) do
    state
    |> Impl.store(key, data)
    |> noreply()
  end

  @impl GenServer
  def handle_call({:get, key}, _from, state) do
    with data <- Impl.get(state, key)
    do
      state
      |> reply(data)
    end
  end


  defp noreply(state) do
    {:noreply, state}
  end

  defp reply(state, msg) do
    {:reply, msg, state}
  end
end
