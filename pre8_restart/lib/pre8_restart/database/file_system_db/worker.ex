defmodule Pre8Restart.Database.FileSystemDb.Worker do
  def new() do
    {:ok, pid} = GenServer.start(__MODULE__.Server, nil)
    pid
  end

  def store(pid, key, value) do
    GenServer.call(pid, {:store, key, value})
    pid
  end

  def clear(pid) do
    GenServer.call(pid, :clear)
  end


  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end
end
