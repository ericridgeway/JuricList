defmodule Pre8Restart.Database.FileSystemDb do
  alias Pre8Restart.{Database}

  @behaviour Database

  @me __MODULE__

  @impl Database
  def start() do
    GenServer.start(__MODULE__.Server, nil, name: @me)
    :ok
  end

  @impl Database
  def store(key, value) do
    GenServer.call(@me, {:store, key, value})
  end

  @spec clear() :: :ok
  def clear() do
    GenServer.call(@me, :clear)
  end


  @impl Database
  def get(key) do
    GenServer.call(@me, {:get, key})
  end
end
