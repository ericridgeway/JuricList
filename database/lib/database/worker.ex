defmodule Database.Worker do

  def start() do
    GenServer.start(__MODULE__.Server, nil)
  end

  def store(pid, key, data) do
    GenServer.call(pid, {:store, key, data})
  end

  def delete(pid, key) do
    GenServer.call(pid, {:delete, key})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end
end
