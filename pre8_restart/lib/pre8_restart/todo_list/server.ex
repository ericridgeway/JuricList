defmodule Pre8Restart.TodoList.Server do
  use GenServer

  alias Pre8Restart.TodoList.{State}

  @impl GenServer
  def init(_init_arg) do
    {:ok, State.new()}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, state) do
    {:noreply, State.add_entry(state, entry)}
  end

  @impl GenServer
  def handle_cast({:update_entry, id, updater_fun}, state) do
    {:noreply, State.update_entry(state, id, updater_fun)}
  end

  @impl GenServer
  def handle_cast({:update_entry, updated_entry}, state) do
    {:noreply, State.update_entry(state, updated_entry)}
  end

  @impl GenServer
  def handle_cast({:delete_entry, id}, state) do
    {:noreply, State.delete_entry(state, id)}
  end


  @impl GenServer
  def handle_call({:titles, target_date}, _from, state) do
    {:reply, State.titles(state, target_date), state}
  end

  @impl GenServer
  def handle_call({:entries, target_date}, _from, state) do
    {:reply, State.entries(state, target_date), state}
  end
end
