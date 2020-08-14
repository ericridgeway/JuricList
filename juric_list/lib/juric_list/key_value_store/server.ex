defmodule JuricList.KeyValueStore.Server do
  use GenServer

  alias JuricList.KeyValueStore.Impl

  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, Impl.put(state, key, value)}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Impl.get(state, key), state}
  end
end
