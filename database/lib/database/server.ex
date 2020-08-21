defmodule Database.Server do
  use GenServer

  alias Database.{Impl}

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
  def handle_call({:get, key}, _from, state) do
    state
    |> reply(Impl.get(state, key))
  end


  defp reply(state, msg) do
    {:reply, msg, state}
  end
end
