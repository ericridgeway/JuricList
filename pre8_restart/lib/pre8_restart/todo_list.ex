defmodule Pre8Restart.TodoList do
  @type t :: pid

  def new(name) do
    {:ok, pid} = GenServer.start(__MODULE__.Server, name)
    pid
  end

  def add_entry(pid, entry) do
    :ok = GenServer.call(pid, {:add_entry, entry})
    pid
  end

  def update_entry(pid, id, updater_fun) do
    :ok = GenServer.call(pid, {:update_entry, id, updater_fun})
    pid
  end

  def update_entry(pid, updated_entry) do
    :ok = GenServer.call(pid, {:update_entry, updated_entry})
    pid
  end

  def delete_entry(pid, id) do
    :ok = GenServer.call(pid, {:delete_entry, id})
    pid
  end


  def titles(pid, target_date) do
    GenServer.call(pid, {:titles, target_date})
  end

  def entries(pid, target_date) do
    GenServer.call(pid, {:entries, target_date})
  end

  def name(pid) do
    GenServer.call(pid, {:name})
  end
end
