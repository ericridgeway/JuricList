defmodule Pre8Restart.TodoServer do
  use GenServer

  alias Pre8Restart.{TodoList}

  def start() do
    GenServer.start(__MODULE__, nil)
  end

  def add_entry(pid, entry) do
    GenServer.cast(pid, {:add_entry, entry})
  end

  def update_entry(pid, id, updater_fun) do
    GenServer.cast(pid, {:update_entry, id, updater_fun})
  end

  def update_entry(pid, updated_entry) do
    GenServer.cast(pid, {:update_entry, updated_entry})
  end

  def delete_entry(pid, id) do
    GenServer.cast(pid, {:delete_entry, id})
  end


  def titles(pid, target_date) do
    GenServer.call(pid, {:titles, target_date})
  end

  def entries(pid, target_date) do
    GenServer.call(pid, {:entries, target_date})
  end


  @impl GenServer
  def init(_init_arg) do
    {:ok, TodoList.new()}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, state) do
    {:noreply, TodoList.add_entry(state, entry)}
  end

  @impl GenServer
  def handle_cast({:update_entry, id, updater_fun}, state) do
    {:noreply, TodoList.update_entry(state, id, updater_fun)}
  end

  @impl GenServer
  def handle_cast({:update_entry, updated_entry}, state) do
    {:noreply, TodoList.update_entry(state, updated_entry)}
  end

  @impl GenServer
  def handle_cast({:delete_entry, id}, state) do
    {:noreply, TodoList.delete_entry(state, id)}
  end


  @impl GenServer
  def handle_call({:titles, target_date}, _from, state) do
    {:reply, TodoList.titles(state, target_date), state}
  end

  @impl GenServer
  def handle_call({:entries, target_date}, _from, state) do
    {:reply, TodoList.entries(state, target_date), state}
  end
end
