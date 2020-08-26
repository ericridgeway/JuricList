defmodule Pre8Restart.TodoList do
  def new() do
    {:ok, pid} = GenServer.start(__MODULE__.Server, nil)
    pid
  end

  def add_entry(pid, entry) do
    GenServer.cast(pid, {:add_entry, entry})
    pid
  end

  def update_entry(pid, id, updater_fun) do
    GenServer.cast(pid, {:update_entry, id, updater_fun})
    pid
  end

  def update_entry(pid, updated_entry) do
    GenServer.cast(pid, {:update_entry, updated_entry})
    pid
  end

  def delete_entry(pid, id) do
    GenServer.cast(pid, {:delete_entry, id})
    pid
  end


  def titles(pid, target_date) do
    GenServer.call(pid, {:titles, target_date})
  end

  def entries(pid, target_date) do
    GenServer.call(pid, {:entries, target_date})
  end
end
