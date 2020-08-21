defmodule Database do
  alias Database.{Worker}

  @me __MODULE__

  def start() do
    GenServer.start(__MODULE__.Server, nil, name: @me)
  end

  def store(key, data) do
    GenServer.call(@me, {:store, key, data})
  end

  def get(key) do
    GenServer.call(@me, {:get, key})
  end
end
