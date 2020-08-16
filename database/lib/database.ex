defmodule Database do

  @me __MODULE__

  def start() do
    GenServer.start(__MODULE__.Server, nil, name: @me)
  end

  def store(key, data) do
    GenServer.cast(@me, {:store, key, data})
  end

  def get(key) do
    GenServer.call(@me, {:get, key})
  end
end
