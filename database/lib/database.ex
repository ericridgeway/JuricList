defmodule Database do
  alias Database.{Worker}

  @me __MODULE__

  # defdelegate start(), to: Worker
  defdelegate store(key, data), to: Worker
  defdelegate delete(key), to: Worker
  defdelegate get(key), to: Worker

  def start() do
    GenServer.start(__MODULE__.Server, nil, name: @me)
  end
end
