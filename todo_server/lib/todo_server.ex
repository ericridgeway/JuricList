defmodule TodoServer do

  # TODO temp default name until update old api in tests to always pass name
  def start(name \\ "todoNameDude") do
    GenServer.start(__MODULE__.Server, name)
  end

  def add_entry(pid, entry) do
    GenServer.cast(pid, {:add_entry, entry})
  end

  def update_entry(pid, id, updater_fun) do
    GenServer.cast(pid, {:update_entry, id, updater_fun})
  end

  def delete_entry(pid, id) do
    GenServer.cast(pid, {:delete_entry, id})
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})
  end

  def name(pid) do
    GenServer.call(pid, :name)
  end
end
