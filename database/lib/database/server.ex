defmodule Database.Server do
  use GenServer

  alias Database.{Impl}

  @impl GenServer
  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  @impl GenServer
  def handle_call({:store, key, data}, _from, state) do
    with {reply, state} <- Impl.store(state, key, data) do
      state
      |> reply(reply)
    end
  end


  defp reply(state, msg) do
    {:reply, msg, state}
  end
end
