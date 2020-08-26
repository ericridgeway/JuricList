defmodule Pre8Restart.TodoList.Server do
  use GenServer

  alias Pre8Restart.TodoList.{State}

  @impl GenServer
  def init(_init_arg) do
    {:ok, State.new()}
  end

  @impl GenServer
  def handle_call({:add_entry, entry}, _from, state) do
    {:reply, :ok, State.add_entry(state, entry)}
  end

  @impl GenServer
  def handle_call({:update_entry, id, updater_fun}, _from, state) do
    {:reply, :ok, State.update_entry(state, id, updater_fun)}
  end

  @impl GenServer
  def handle_call({:update_entry, updated_entry}, _from, state) do
    {:reply, :ok, State.update_entry(state, updated_entry)}
  end

  @impl GenServer
  def handle_call({:delete_entry, id}, _from, state) do
    {:reply, :ok, State.delete_entry(state, id)}
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
