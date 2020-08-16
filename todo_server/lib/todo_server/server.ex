defmodule TodoServer.Server do
  use GenServer

  alias TodoServer.{Impl}

  def init(_init_arg) do
    {:ok, Impl.new()}
  end

  def handle_cast({:add_entry, entry}, state) do
    {:noreply, Impl.add_entry(state, entry)}
  end

  def handle_cast({:update_entry, id, updater_fun}, state) do
    {:noreply, Impl.update_entry(state, id, updater_fun)}
  end

  def handle_cast({:delete_entry, id}, state) do
    {:noreply, Impl.delete_entry(state, id)}
  end

  def handle_call({:entries, date}, _sender, state) do
    {:reply, Impl.entries(state, date), state}
  end
end

