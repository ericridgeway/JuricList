defmodule Pre8Restart.Database.NothingDb do
  alias Pre8Restart.{Database}

  @behaviour Database

  @impl Database
  def start(), do: :ok

  @impl Database
  def store(_key, _value), do: :ok

  @impl Database
  def get(_key), do: nil
end
