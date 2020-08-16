defmodule Database.Server do
  use GenServer

  @impl GenServer
  def init(_init_arg) do
    {:ok, -1}
  end

  @impl GenServer
  def handle_cast({:store, key, data}, state) do
    {:noreply, state}
  end

  @impl GenServer
  def handle_call({:get, key}, _from, state) do
    {:reply, "is batman", state}
  end
end

