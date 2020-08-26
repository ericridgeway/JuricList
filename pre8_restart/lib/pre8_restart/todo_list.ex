defmodule Pre8Restart.TodoList do
  def start() do
    GenServer.start(__MODULE__.Server, nil)
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
end
