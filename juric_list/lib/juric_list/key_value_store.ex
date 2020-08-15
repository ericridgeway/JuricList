defmodule JuricList.KeyValueStore do
  def start() do
    GenServer.start(__MODULE__.Server, nil)
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end
end

