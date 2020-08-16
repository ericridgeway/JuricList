defmodule TodoServer.Server do
  use GenServer

  alias TodoServer.{Impl}

  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  def handle_cast({:add_entry, entry}, state) do
    state
    |> Impl.add_entry(entry)
    |> noreply()
  end

  def handle_cast({:update_entry, id, updater_fun}, state) do
    state
    |> Impl.update_entry(id, updater_fun)
    |> noreply()
  end

  def handle_cast({:delete_entry, id}, state) do
    state
    |> Impl.delete_entry(id)
    |> noreply()
  end

  def handle_call({:entries, date}, _sender, state) do
    with entries <- Impl.entries(state, date)
    do
      state
      |> reply(entries)
    end
  end


  defp noreply(state) do
    {:noreply, state}
  end

  defp reply(state, msg) do
    {:reply, msg, state}
  end
end
